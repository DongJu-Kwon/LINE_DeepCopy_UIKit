//
//  Images.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/02/01.
//

import UIKit

extension UIImage {
    private func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func resizedToSquare(number: CGFloat) -> UIImage {
        return self.resized(to: CGSize(width: number, height: number)).withRenderingMode(.alwaysTemplate)
    }
    
    var forTabbarItem: UIImage {
        self.resizedToSquare(number: Constants.TabBar.ImageHeight.itself)
    }
    
    var forNavigationBarXmark: UIImage {
        self.resizedToSquare(number: Constants.NavigationBar.ImageHeight.xmark)
    }
    
    var forProfileUIBarButtonItem: UIImage {
        self.resizedToSquare(number: 33)
    }
    
    var forUIBarButtonItem: UIImage {
        self.resizedToSquare(number: 23)
    }
    
    var forTextFieldClearButton: UIImage {
        self.resizedToSquare(number: 18)
    }
    
    var forTextfieldSearch: UIImage {
        self.resizedToSquare(number:  Constants.TextField.ImageHeight.search)
    }
    
    var forTextfieldBarcode: UIImage {
        self.resizedToSquare(number: Constants.TextField.ImageHeight.barcode)
    }
    
    var forCallCellProfile: UIImage {
        self.resizedToSquare(number: Constants.CallView.ImageHeight.profile)
    }
    
    var forCallCellFrom: UIImage {
        self.resizedToSquare(number: Constants.CallView.ImageHeight.from)
    }
    
    var forCallCellCall: UIImage {
        self.resizedToSquare(number: Constants.CallView.ImageHeight.call)
    }
    
    var forContactCellProfile: UIImage {
        self.resizedToSquare(number: Constants.ContactView.ImageHeight.profile)
    }
    
    var forContactCellLine: UIImage {
        self.resizedToSquare(number: Constants.ContactView.ImageHeight.line)
    }
    
    var forContactCellCall: UIImage {
        self.resizedToSquare(number: Constants.ContactView.ImageHeight.call)
    }
    
    var forContactDetailProfile: UIImage {
        self.resizedToSquare(number: Constants.ContactDetailView.ProfileView.ImageHeight.profile)
    }
    
    var forContactDetailButton: UIImage {
        self.resizedToSquare(number: Constants.ContactDetailView.ButtonView.ImageHeight.itself)
    }
    
    var forContactDetailFrom: UIImage {
        self.resizedToSquare(number: Constants.ContactDetailView.TableView.ImageHeight.from)
    }
}
