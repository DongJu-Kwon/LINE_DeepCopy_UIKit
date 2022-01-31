//
//  Friend.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/20.
//

import Foundation
import UIKit

class Friend {
    var image: UIImage
    var name: String
    
    init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
}

class FriendList {
    static let shared = FriendList()
    
    private init() {}
    
    private static var imageArray = [
        UIImage(systemName: "flame.circle")!,
        UIImage(systemName: "person.circle")!,
        UIImage(systemName: "person.crop.circle")!,
        UIImage(systemName: "circle.circle")!,
        UIImage(systemName: "graduationcap.circle")!,
        UIImage(systemName: "drop.circle")!,
        UIImage(systemName: "stop.circle")!,
    ]
    
    private static var friendArray: [Friend] = [
        "권오승",
        "김민서소영",
        "김시본",
        "깡견깡견깡견깡견깡견깡견깡견깡견깡견깡견",
        "린파나요우",
        "맹돌이",
        "배현규",
        "성재혁",
        "소라",
        "신승철",
        "안지섭",
        "용현석",
        "유현준",
        "윤봉준",
        "이가연",
        "이건우",
        "이재봉",
        "진영",
        "휘창",
        "Amy Kim",
        "ash",
        "Baek Gayoung",
        "COKE",
        "DKDK",
        "Ejin",
        "English teacher",
        "H",
        "ht",
        "Jason",
        "JS",
        "Maria Alejandra Kwon",
        "TJ",
        "Yejin Jo",
        "YeongJaeKo",
        "..",
        "ウジュ",
        "😱😱😱",
    ].shuffled().map {
        Friend(image: FriendList.imageArray.randomElement()!, name: $0)
    }
    
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
        let dictionary = Dictionary(grouping: FriendList.friendArray) {
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
