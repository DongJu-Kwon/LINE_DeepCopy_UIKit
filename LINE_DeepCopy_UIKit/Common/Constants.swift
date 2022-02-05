//
//  Constants.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/20.
//

import UIKit

struct Constants {
    struct NavigationBar {
        struct ImageHeight {
            static let xmark: CGFloat = 18
        }
    }
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
    
    struct CallCell {
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
            static let profileNameBottom: CGFloat = 5
            static let callDateLeading: CGFloat = 5
            static let callButtonTrailing: CGFloat = -20
        }
    }
    
    struct ContactView {
        struct ViewHeight {
            static let section: CGFloat = 22
            static let cell: CGFloat = 60
        }
        struct ImageHeight {
            static let profile: CGFloat = 43
            static let line: CGFloat = 19
            static let call: CGFloat = 18
        }
        struct Padding {
            static let sectionLeading: CGFloat = 14
            static let profileImageLeading: CGFloat = 12
            static let profileNameLeading: CGFloat = 12
            static let callButtonTrailing: CGFloat = -20
        }
    }
    
    struct ContactDetailView {
        struct ScrollView {
            struct ViewHeight {
                static var itself: CGFloat {
                    ProfileView.ViewHeight.itself + ButtonView.ViewHeight.itself
                }
            }
            struct Padding {
                static var horizontal: CGFloat = 28
            }
        }
        struct ProfileView {
            struct ViewHeight {
                static let itself: CGFloat = 148
            }
            struct ImageHeight {
                static let profile: CGFloat = 60
            }
            struct Padding {
                static let topAnchor: CGFloat = 10
                static let imageLeading: CGFloat = 25
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
            struct ViewWidth {
                static let timeText: CGFloat = 40
                static let callTypeText: CGFloat = 60
            }
            struct ImageHeight {
                static let from: CGFloat = 9
            }
            struct Padding {
                static let sectionLeading: CGFloat = 30
                static let sectionBottom: CGFloat = -5
                static let callFromImageLeading: CGFloat = 33
                static let timeTextLeading: CGFloat = 14
                static let callTypeTextLeading: CGFloat = 5
                static let fromTypeTextTrailing: CGFloat = -30
            }
        }
    }
}
