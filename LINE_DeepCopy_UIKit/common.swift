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
    
    var resizeForProfileUIBarButtonItem: UIImage {
        self.resized(to: CGSize(width: 33, height: 33)).withRenderingMode(.alwaysTemplate)
    }
    
    var resizeForUIBarButtonItem: UIImage {
        self.resized(to: CGSize(width: 23, height: 23)).withRenderingMode(.alwaysTemplate)
    }
}

class CustomLabel: UILabel {
    init(_ string: String) {
        super.init(frame: .zero)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.7
        paragraphStyle.alignment = .center
        
        self.attributedText = NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle])
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomLabel: Margin {}

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
    init(image: UIImage, isProfile: Bool = false) {
        super.init()
        
        let button = UIButton()
        button.setImage(isProfile ? image.resizeForProfileUIBarButtonItem : image.resizeForUIBarButtonItem, for: .normal)
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
