//
//  Fonts.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/19.
//

// black heavy bold semibold medium regular light thin ultraLight

import UIKit

extension UIFont {
    static var forTabBarItemTitle: UIFont {
        UIFont.systemFont(ofSize: 9, weight: .black)
    }
    
    static var forUIBarButtonItem: UIFont {
        UIFont.systemFont(ofSize: 23, weight: .black)
    }
    
    static var forTextFieldPlaceholder: UIFont {
        UIFont.systemFont(ofSize: 12, weight: .medium)
    }
    
    static var forProfileUIBarButtonItem: UIFont {
        UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    static var forInformTitle: UIFont {
        UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    static var forInformContent: UIFont {
        UIFont.systemFont(ofSize: 13.2, weight: .regular)
    }
    
    static var forInformButton: UIFont {
        UIFont.systemFont(ofSize: 13, weight: .semibold)
    }
    
    static var forCallCellName: UIFont {
        UIFont.systemFont(ofSize: 12.5, weight: .regular)
    }
    
    static var forCallCellDate: UIFont {
        UIFont.systemFont(ofSize: 10.5, weight: .regular)
    }
    
    static var forContactTableSection: UIFont {
        UIFont.systemFont(ofSize: 13, weight: .bold)
    }
    
    static var forContactTableCellName: UIFont {
        UIFont.systemFont(ofSize: 12, weight: .light)
    }
    
    static var forContactDetailProfileFriendName: UIFont {
        UIFont.systemFont(ofSize: 30, weight: .bold)
    }
    
    static var forContactDetailButton: UIFont {
        UIFont.systemFont(ofSize: 10, weight: .regular)
    }
    
    static var forContactDetailTableSection: UIFont {
        UIFont.systemFont(ofSize: 13, weight: .bold)
    }
    
    static var forContactDetailTableCell: UIFont {
        UIFont.systemFont(ofSize: 13, weight: .light)
    }
}
