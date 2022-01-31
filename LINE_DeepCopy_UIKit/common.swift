//
//  common.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import Foundation
import UIKit
import Then

extension UIImage {
    private func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func resizedToSquare(number: CGFloat) -> UIImage {
        return self.resized(to: CGSize(width: number, height: number)).withRenderingMode(.alwaysTemplate)
    }
    
    var forNavigationBarXmarkImage: UIImage {
        self.resizedToSquare(number: Constants.NavigationBar.ImageHeight.xmark)
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
    
    var forContactDetailProfileImage: UIImage {
        self.resizedToSquare(number: Constants.ContactDetailView.ProfileView.ImageHeight.profile)
    }
    
    var forContactDetailButtonImage: UIImage {
        self.resizedToSquare(number: Constants.ContactDetailView.ButtonView.ImageHeight.itself)
    }
}

class UIBarButtonItemLabel: UIBarButtonItem {
    init(_ string: String, isProfile: Bool = false) {
        super.init()
        
        self.customView = UILabel().then {
            $0.text = string
            $0.textColor = .white
            $0.font = isProfile ? .forProfileUIBarButtonItem : .forUIBarButtonItem
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UIBarButtonItemButton: UIBarButtonItem {
    public var button = UIButton().then {
        $0.tintColor = .white
    }
    
    init(image: UIImage, defaultHeight: Bool = true) {
        super.init()
        
        button.setImage(defaultHeight ? image.forUIBarButtonItem : image, for: .normal)
        
        self.customView = button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomTextFieldView: UIView {
    let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass")!.forTextfieldSearchImage).then {
        $0.tintColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let barcodeImageView = UIImageView(image: UIImage(systemName: "barcode.viewfinder")!.forTextfieldBarcodeImage).then {
        $0.tintColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let textField = UITextField().then {
        $0.textColor = .gray
        $0.backgroundColor = .selectedGray
        $0.clearButtonMode = .whileEditing
        $0.attributedPlaceholder = NSAttributedString(string: "검색", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font : UIFont.forTextFieldPlaceholder
        ])
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(forContactView: Bool = false) {
        super.init(frame: .zero)
        self.backgroundColor = .selectedGray
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        
        self.addSubview(searchImageView)
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

class CustomLabel: UILabel {
    let paragraphStyle = NSMutableParagraphStyle().then {
        $0.lineSpacing = 2.7
        $0.alignment = .center
    }
    
    init(_ string: String) {
        super.init(frame: .zero)
        
        self.attributedText = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(_ string: String, alignLeft: Bool) {
        self.init(string)
        
        self.attributedText = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomScrollView: UIScrollView {
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomView: UIView {
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
