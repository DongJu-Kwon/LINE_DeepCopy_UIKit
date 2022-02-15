//
//  Constants.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/20.
//

import UIKit

struct Constants {
    struct TabBar {
        struct ImageHeight {
            static let itself: CGFloat = 23
        }
    }
    struct NavigationBar {
        struct ImageHeight {
            static let xmark: CGFloat = 18
        }
    }
    struct TextField {
        struct ViewHeight {
            static let ifself: CGFloat = 42
        }
        struct ImageHeight {
            static let search: CGFloat = 13
            static let barcode: CGFloat = 16
        }
        struct Padding {
            static let top: CGFloat = 3
            static let horizontal: CGFloat = 17
            static let searchLeading: CGFloat = 13
            static let textfieldLeading: CGFloat = 7
            static let textfieldTrailing: CGFloat = -7
            static let barcodeTrailing: CGFloat = -13
            
//            static let textfieldTrailingForContact: CGFloat = -15
        }
    }
    
    struct CallView {
        struct ViewHeight {
            static let cell: CGFloat = 70
        }
        struct ImageHeight {
            static let profile: CGFloat = 50
            static let from: CGFloat = 12
            static let call: CGFloat = 20
        }
        struct Padding {
            static let profileImageLeading: CGFloat = 12
            static let informationLeading: CGFloat = 12
            static let informationTrailing: CGFloat = -23
            static let profileNameBottom: CGFloat = 5
            static let historyCountLeading: CGFloat = 4
            static let historyCountTrailing: CGFloat = -7
            static let callDateLeading: CGFloat = 5
            static let callButtonTrailing: CGFloat = -20
        }
    }
    
    struct ContactView {
        struct ViewWidth {
            static let cancelButton: CGFloat = 46
        }
        struct ViewHeight {
            static let cancelButton = TextField.ViewHeight.ifself - 12
            static let header: CGFloat = 22
            static let footer: CGFloat = 40
            static let cell: CGFloat = 60
        }
        struct ImageHeight {
            static let profile: CGFloat = 43
            static let line: CGFloat = 19
            static let call: CGFloat = 18
        }
        struct Padding {
            static let textFieldViewTrailingAfterShowing = -TextField.Padding.horizontal - 55
            static let cancelButtonLeadingBeforeShowing: CGFloat = 17
            static let cancelButtonLeadingAfterShowing: CGFloat = 12
            static let sectionLeading: CGFloat = 14
            static let profileImageLeading: CGFloat = 12
            static let profileNameLeading: CGFloat = 12
            static let callButtonTrailing: CGFloat = -20
            static let notFoundTop: CGFloat = 180
        }
    }
    
    struct ContactDetailView {
        struct ProfileView {
            struct ViewHeight {
                static let itself: CGFloat = 148
                static let subView = Padding.topAnchor*2 + ImageHeight.profile
            }
            struct ImageHeight {
                static let profile: CGFloat = 60
            }
            struct Padding {
                static let topAnchor: CGFloat = 10
                static let horizontal: CGFloat = 28
                static let imageLeading: CGFloat = 25
                static let alphaBottom = ViewHeight.subView + 35
            }
        }
        struct ButtonView {
            struct ViewHeight {
                static let itself: CGFloat = 95
            }
            struct ImageHeight {
                static let itself: CGFloat = 23
            }
            struct Padding {
                static let itself: CGFloat = 7
            }
        }
        struct TableView {
            struct ViewHeight {
                static let section: CGFloat = 60
                static let cell: CGFloat = 35
            }
            struct ImageHeight {
                static let from: CGFloat = 9
            }
            struct Padding {
                static let sectionLeading: CGFloat = 30
                static let sectionBottom: CGFloat = -5
                static let callFromImageLeading: CGFloat = 33
                static let timeTextLeading: CGFloat = 22
                static let callTypeTextLeading: CGFloat = 5
                static let fromTypeTextTrailing: CGFloat = -30
            }
        }
    }
}
