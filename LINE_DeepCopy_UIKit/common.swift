//
//  common.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import Foundation
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
    
    var forProfileUIBarButtonItem: UIImage {
        self.resizedToSquare(number: 33)
    }
    
    var forUIBarButtonItem: UIImage {
        self.resizedToSquare(number: 23)
    }
    
    var forTextfieldSearchImage: UIImage {
        self.resizedToSquare(number:  Constants.TextField.ImageHeight.search)
    }
    
    var forTextfieldBarcodeImage: UIImage {
        self.resizedToSquare(number: Constants.TextField.ImageHeight.barcode)
    }
    
    var forContactProfileImage: UIImage {
        self.resizedToSquare(number: Constants.ContactCell.ImageHeight.profile)
    }
    
    var forContactLineImage: UIImage {
        self.resizedToSquare(number: Constants.ContactCell.ImageHeight.line)
    }
    
    var forContactCallImage: UIImage {
        self.resizedToSquare(number: Constants.ContactCell.ImageHeight.call)
    }
}

class UIBarButtonItemLabel: UIBarButtonItem {
    init(_ string: String, isProfile: Bool = false) {
        super.init()
        
        let label = UILabel()
        label.text = string
        label.textColor = .white
        label.font = isProfile ? .forProfileUIBarButtonItem : .forUIBarButtonItem
        
        self.customView = label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UIBarButtonItemButton: UIBarButtonItem {
    public var button: UIButton!
    
    init(image: UIImage, isProfile: Bool = false) {
        super.init()
        
        button = UIButton()
        button.setImage(isProfile ? image.forProfileUIBarButtonItem : image.forUIBarButtonItem, for: .normal)
        if let target = target, let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        button.tintColor = .white
        
        self.customView = button
    }

    convenience init(image: UIImage, target: Any?, action: Selector, isProfile: Bool = false) {
        self.init(image: image, isProfile: isProfile)
        (self.customView as! UIButton).addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomTextFieldView: UIView {
    let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass")!.forTextfieldSearchImage)
    let barcodeImageView = UIImageView(image: UIImage(systemName: "barcode.viewfinder")!.forTextfieldBarcodeImage)
    let textField = UITextField()
    
    init(forContactView: Bool = false) {
        super.init(frame: .zero)
        self.backgroundColor = .selectedGray
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        
        searchImageView.tintColor = .gray
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchImageView)
        
        textField.textColor = .gray
        textField.backgroundColor = .selectedGray
        textField.clearButtonMode = .whileEditing
        textField.attributedPlaceholder = NSAttributedString(string: "검색", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font : UIFont.forTextFieldPlaceholder
        ])
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        
        NSLayoutConstraint.activate([
            searchImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.TextField.Padding.searchLeading),
            searchImageView.widthAnchor.constraint(equalToConstant: Constants.TextField.ImageHeight.search),
            
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: Constants.TextField.Padding.textfieldLeading)
        ])
        
        if forContactView {
//            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.TextField.Padding.textfieldTrailingForContact).isActive = true
        } else {
            barcodeImageView.tintColor = .gray
            barcodeImageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(barcodeImageView)
            
            NSLayoutConstraint.activate([
                barcodeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                barcodeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.TextField.Padding.barcodeTrailing),
                barcodeImageView.widthAnchor.constraint(equalToConstant: Constants.TextField.ImageHeight.barcode),
                
//                textField.trailingAnchor.constraint(equalTo: barcodeImageView.leadingAnchor, constant: Constants.TextField.Padding.textfieldTrailing)
            ])
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextFieldView: Margin {}

class CustomLabel: UILabel {
    init(_ string: String) {
        super.init(frame: .zero)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.7
        paragraphStyle.alignment = .center
        
        self.attributedText = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(_ string: String, alignLeft: Bool) {
        self.init(string)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.7
        paragraphStyle.alignment = .center
        
        self.attributedText = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomLabel: Margin {}

class CustomScrollView: UIScrollView {
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomScrollView: Margin {}

class CustomView: UIView {
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomView: Margin {}
