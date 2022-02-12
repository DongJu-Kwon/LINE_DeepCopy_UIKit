//
//  common.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import UIKit
import Then

extension String {
    func forPrefixCallCellName(count: Int) -> String {
        return "\(self)⋯ (\(count))"
    }
//    var forPrefixCallCellName: String {
//        self.count > 18 ? "\(self.prefix(18))⋯" : self
//    }
}

extension Date {
    func formatting(with: String) -> String {
        DateFormatter().then {
            $0.dateFormat = with
            $0.timeZone = TimeZone.autoupdatingCurrent
            $0.locale = Locale.current
        }.string(from: self)
    }
    var toKST: String {
        self.formatting(with: "yyyy-MM-dd HH:mm:ss")
    }
    var dropAfterDaysWithKST: String {
        self.formatting(with: "yyyy/MM/dd")
    }
    var filterBeforeHoursWithKST: String {
        self.formatting(with: "HH:mm")
    }
    static func secondsToHours(seconds: Int) -> String {
        var returnValue = ""
        
        if seconds >= 60*60 {
            returnValue += "\(seconds/60/60):\(seconds/60%60 < 10 ? "0" : "")"
        }
        returnValue += "\(seconds/60%60):"
        returnValue += "\(seconds%60 < 10 ? "0" : "")\(seconds%60)"
        
        return returnValue
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var nextDay: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var previousDay: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    var lastMonday: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self))!.nextDay
    }
    
    var startOfMonth: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self.startOfDay))!
    }
    
    var startOfYear: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year], from: self.startOfDay))!
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
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
    let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass")!.forTextfieldSearch).then {
        $0.tintColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let barcodeImageView = UIImageView(image: UIImage(systemName: "barcode.viewfinder")!.forTextfieldBarcode).then {
        $0.tintColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let textField = UITextField().then {
        $0.backgroundColor = .selectedGray
        $0.clearButtonMode = .always
        $0.attributedPlaceholder = NSAttributedString(string: "검색", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.forTextField
        ])
        
        if let button = $0.value(forKey: "_clearButton") as? UIButton {
            button.setImage(button.imageView!.image!.forTextFieldClearButton, for: .normal)
            button.tintColor = .gray
        }
        
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var textFieldTrailingAnthor: NSLayoutConstraint!
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .selectedGray
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        
        self.addSubview(searchImageView)
        self.addSubview(textField)
        self.addSubview(barcodeImageView)
        
        self.textFieldTrailingAnthor = textField.trailingAnchor.constraint(equalTo: barcodeImageView.leadingAnchor, constant: Constants.TextField.Padding.textfieldTrailing).then {
            $0.isActive = true
        }
        
        NSLayoutConstraint.activate([
            searchImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.TextField.Padding.searchLeading),
            searchImageView.widthAnchor.constraint(equalToConstant: Constants.TextField.ImageHeight.search),
            
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: Constants.TextField.Padding.textfieldLeading),
            
            barcodeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            barcodeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.TextField.Padding.barcodeTrailing),
            barcodeImageView.widthAnchor.constraint(equalToConstant: Constants.TextField.ImageHeight.barcode),
        ])
        
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

class ProfileWithLineImageView: UIImageView {
    let lineImageView = UIImageView(image: UIImage(systemName: "message.fill")!.forContactCellLine).then {
        $0.tintColor = .green
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init() {
        super.init(frame: .zero)
        
        addSubview(lineImageView)
        NSLayoutConstraint.activate([
            lineImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lineImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
