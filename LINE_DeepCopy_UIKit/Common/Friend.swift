//
//  Friend.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/20.
//

import Foundation
import UIKit

class Friend {
    var image: UIImage!
    var name: String!
    
    init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
}

class FriendList {
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
    
    static var friendArray: [Friend] = [
        "권오승",
        "김민서소영",
        "김시본",
        "깡견",
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
    ]
        .shuffled()
        .map {
            Friend(image: FriendList.imageArray.randomElement()!, name: $0)
    }
    
//    static var indexedFriendArray: [String: [Friend]] = {
//        friendArray.sorted(by: {
//            return $0.name < $1.name
//        })
//    }
    
    private let hangul = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]

    private func consonant(word: String) -> String {
        let octal = word.unicodeScalars[word.unicodeScalars.startIndex].value
        let index = (octal - 0xac00) / 28 / 21
        
        return hangul[Int(index)]
    }
    
    private func groupKey(string: String) -> String {
        switch string.first! {
        case "A"..."Z", "a"..."z", "ㄱ"..."ㅎ":
            return String(string.first!.uppercased())
        case "가"..."힣":
            return consonant(word: string)
        default:
            return "#"
        }
    }
    
    // let b = Dictionary(grouping: a, by: { groupKey(string: $0)})
    
    var sortedFriendWithKey: [String: [Friend]] {
        
        
        
        return [:]
    }
}
