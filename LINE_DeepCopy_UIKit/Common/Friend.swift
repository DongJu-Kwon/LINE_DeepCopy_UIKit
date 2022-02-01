//
//  Friend.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/20.
//

import Foundation
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
        
        var callType: CallType
        var fromType: FromType
        var date: Date
        weak var parent: Friend!
        
        init(type: CallType, from: FromType, date: Date, parent: Friend) {
            self.callType = type
            self.fromType = from
            self.date = date
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
        self.callHistory.sorted {
            $0.date > $1.date
        }
    }
    
    var lastCallHistroy: CallHistory? {
        self.sortedCallHistory.first
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

extension Friend.CallHistory: Equatable, Hashable {
    static func == (lhs: Friend.CallHistory, rhs: Friend.CallHistory) -> Bool {
        return lhs.date == rhs.date
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.date)
    }
}

class FriendList {
    static let shared = FriendList()
    
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
    
    public var sortedFriendWithKey: [(String, [Friend])] {
        let dictionary = Dictionary(grouping: self.friendArray) {
            FriendList.shared.groupKey(string: $0.name)
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
}
