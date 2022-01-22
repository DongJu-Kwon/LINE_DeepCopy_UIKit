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
    
    static var forNavigationTitle: UIFont {
        UIFont.systemFont(ofSize: 20, weight: .bold)
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
    
    static var forContactName: UIFont {
        UIFont.systemFont(ofSize: 12, weight: .light)
    }
}
