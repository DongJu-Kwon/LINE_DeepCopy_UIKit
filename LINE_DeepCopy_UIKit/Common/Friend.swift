//
//  Friend.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/20.
//

import UIKit

class Friend {
    class CallHistory {
        enum FromType {
            enum send {
                case cancelled
                case called(Int)
            }
            enum receive {
                case missed
                case called(Int)
            }
            
            case sender(send)
            case receiver(receive)
        }
        enum CallType {
            case voice
            case video
        }
        
        var fromType: FromType
        var callType: CallType
        var timestamp: Date
        unowned var parent: Friend
        
        init(type: CallType, from: FromType, date: Date, parent: Friend) {
            self.callType = type
            self.fromType = from
            self.timestamp = date
            self.parent = parent
        }
    }
    
    var image: UIImage
    var name: String
    var callHistory: [CallHistory] = []
    
    init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
    
    var sortedCallHistory: [CallHistory] {
        self.callHistory.sorted()
    }
    
    var lastCallHistroy: CallHistory? {
        self.sortedCallHistory.first
    }
    
    enum PastDateGroupKey: String {
        case today = "오늘"
        case yesterday = "어제"
        case beforeYesterday = "그제"
        case thisWeek = "이번 주"
        case lastWeek = "저번 주"
        case thisMonth = "이번 달"
        case lastMonth = "저번 달"
        case thisYear = "올해"
        case lastYear = "작년"
        case past = "오래 전"
        
        var orderValue: Int {
            [
                .today,
                .yesterday,
                .beforeYesterday,
                .thisWeek,
                .lastWeek,
                .thisMonth,
                .lastMonth,
                .thisYear,
                .lastYear,
                .past
            ].firstIndex(of: self)!
        }
    }
    
    func groupKeyWithDate(history: CallHistory) -> PastDateGroupKey {
        let startOfToday = Date().startOfDay
        
        switch history.timestamp {
        case startOfToday...:
            return .today
        case startOfToday.previousDay...:
            return .yesterday
        case startOfToday.previousDay.previousDay...:
            return .beforeYesterday
        case startOfToday.lastMonday...:
            return .thisWeek
        case startOfToday.lastMonday.previousDay.lastMonday...:
            return .lastWeek
        case startOfToday.startOfMonth:
            return .thisMonth
        case startOfToday.startOfMonth.previousDay.startOfMonth:
            return .lastMonth
        case startOfToday.startOfYear:
            return .thisYear
        case startOfToday.startOfYear.previousDay.startOfYear:
            return .lastYear
        default:
            return .past
        }
    }
    
    var sortedCallHistoryWithKey: [(Date, [CallHistory])] {
//        let dictionary = Dictionary(grouping: self.callHistory) {
//            self.groupKeyWithDate(history: $0)
//        }
//
//        return Array(dictionary.keys).sorted {
//            $0.orderValue < $1.orderValue
//        }.map {
//            ($0, dictionary[$0]!.sorted())
//        }
        let dictionary = Dictionary(grouping: self.callHistory) {
            $0.timestamp.startOfDay
        }
        return Array(dictionary.keys).sorted().reversed().map {
            ($0, dictionary[$0]!.sorted())
        }
    }
}

extension Friend: Equatable, Hashable {
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }
}

extension Friend.CallHistory: Equatable, Hashable, Comparable {
    static func == (lhs: Friend.CallHistory, rhs: Friend.CallHistory) -> Bool {
        return lhs.timestamp == rhs.timestamp
    }
    
    static func < (lhs: Friend.CallHistory, rhs: Friend.CallHistory) -> Bool {
        return lhs.timestamp > rhs.timestamp
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.timestamp)
    }
}

class FriendManager {
    static let shared = FriendManager()
    private init() {}
    
    var friendArray: [Friend] = []
    
    private let hangul = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]

    private func consonant(word: String) -> String {
        let octal = word.unicodeScalars[word.unicodeScalars.startIndex].value
        let index = Int((octal - 0xac00) / 28 / 21)
        
        switch index {
        case 1, 4, 8, 10, 13:
            return hangul[index-1]
        default:
            return hangul[index]
        }
    }
    
    private func groupKey(string: String) -> String {
        switch string.first! {
        case "ㄱ"..."ㅎ", "A"..."Z", "a"..."z":
            return String(string.first!.uppercased())
        case "가"..."힣":
            return consonant(word: string)
        default:
            return "#"
        }
    }
    
    public var sortedFriendWithKey: [(key: String, friends: [Friend])] {
        let dictionary = Dictionary(grouping: self.friendArray) {
            FriendManager.shared.groupKey(string: $0.name)
        }
        
        return Array(dictionary.keys).sorted {
            switch ($0, $1) {
            case ("ㄱ"..."ㅎ", "ㄱ"..."ㅎ"), ("A"..."Z", "A"..."Z"):
                return $0 < $1
            case ("ㄱ"..."ㅎ", "A"..."Z"):
                return true
            case ("A"..."Z", "ㄱ"..."ㅎ"):
                return false
            case ("ㄱ"..."ㅎ", _), ("A"..."Z", _):
                return true
            case (_, "ㄱ"..."ㅎ"), (_, "A"..."Z"):
                return false
            default:
                return true
            }
        }.map {
            ($0, dictionary[$0]!.sorted {
                $0.name < $1.name
            })
        }
    }
    
    private var searchKeyword = "" {
        willSet(newValue) {
            if searchKeyword != newValue {
                self.friendsWhoseNameContainsSearchKeyword = self.sortedFriendWithKey.map {
                    $0.friends
                }.flatMap {
                    $0
                }.filter {
                    $0.name.lowercased().contains(newValue.lowercased())
                }
            }
        }
    }
    private var friendsWhoseNameContainsSearchKeyword: [Friend] = []
    
    public func friendsWhoseNameContains(string: String) -> [Friend] {
        self.searchKeyword = string
        return self.friendsWhoseNameContainsSearchKeyword
    }
}
