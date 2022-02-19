//
//  SearchHistory.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/02/19.
//

import UIKit

class SearchHistoryManager {
    static let shared = SearchHistoryManager()
    private init() {}
    
    var histories: [SearchHistory] = []
    
    var sortedHistories: [SearchHistory] {
        histories.sorted()
    }
}

class SearchHistory {
    enum SearchType {
        case `default`(String)
        case profile(Friend)
        case chatRoom(Friend)
    }
    
    var type: SearchType
    var timestamp: Date
    
    init(type: SearchType) {
        self.type = type
        self.timestamp = Date()
    }
}

extension SearchHistory: Equatable, Hashable, Comparable {
    static func == (lhs: SearchHistory, rhs: SearchHistory) -> Bool {
        return lhs.timestamp == rhs.timestamp && lhs.type == rhs.type
    }
    
    static func < (lhs: SearchHistory, rhs: SearchHistory) -> Bool {
        return lhs.timestamp > rhs.timestamp
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.timestamp)
    }
}

extension SearchHistory.SearchType: Equatable {
    static func == (lhs: SearchHistory.SearchType, rhs: SearchHistory.SearchType) -> Bool {
        switch (lhs, rhs) {
        case (.default(let lhsKeyword), .default(let rhsKeyword)):
            return lhsKeyword == rhsKeyword
        case (.profile(let lhsFriend), .profile(let rhsFriend)), (.chatRoom(let lhsFriend), .chatRoom(let rhsFriend)):
            return lhsFriend == rhsFriend
        default:
            return false
        }
    }
}
