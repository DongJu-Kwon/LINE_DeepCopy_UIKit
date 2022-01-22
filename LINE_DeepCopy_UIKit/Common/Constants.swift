//
//  Constants.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/20.
//

import UIKit

struct Constants {
    struct TextField {
        struct ViewHeight {
            static let ifself: CGFloat = 36
        }
        struct ImageHeight {
            static let search: CGFloat = 13
            static let barcode: CGFloat = 16
        }
        
        struct Margin {
            static let horizontal: CGFloat = 17
        }
        
        struct Padding {
            static let searchLeading: CGFloat = 13
            static let textfieldLeading: CGFloat = 7
//            static let textfieldTrailing: CGFloat = -12
            static let barcodeTrailing: CGFloat = -13
            
//            static let textfieldTrailingForContact: CGFloat = -15
        }
    }
    
    struct ContactCell {
        struct ViewHeight {
            static let section: CGFloat = 22
            static let cell: CGFloat = 60
        }
        
        struct ImageHeight {
            static let profile: CGFloat = 43
            static let line: CGFloat = 19
            static let call: CGFloat = 18
        }
    }
}
