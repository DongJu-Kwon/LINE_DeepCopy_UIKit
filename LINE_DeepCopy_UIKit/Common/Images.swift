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
    
    var forNavigationBarXmark: UIImage {
        self.resizedToSquare(number: Constants.NavigationBar.ImageHeight.xmark)
    }
    
    var forProfileUIBarButtonItem: UIImage {
        self.resizedToSquare(number: 33)
    }
    
    var forUIBarButtonItem: UIImage {
        self.resizedToSquare(number: 23)
    }
    
    var forCallCellProfile: UIImage {
        self.resizedToSquare(number: Constants.CallCell.ImageHeight.profile)
    }
    
    var forCallCellFrom: UIImage {
        self.resizedToSquare(number: Constants.CallCell.ImageHeight.from)
    }
    
    var forCallCellCall: UIImage {
        self.resizedToSquare(number: Constants.CallCell.ImageHeight.call)
    }
    
    var forTextfieldSearch: UIImage {
        self.resizedToSquare(number:  Constants.TextField.ImageHeight.search)
    }
    
    var forTextfieldBarcodeㅋ: UIImage {
        self.resizedToSquare(number: Constants.TextField.ImageHeight.barcode)
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