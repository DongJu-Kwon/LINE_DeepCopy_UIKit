//
//  common.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import Foundation
import UIKit

extension UIColor {
    static let background = UIColor(named: "color_background")
    static let gray = UIColor(named: "color_gray")
    
    static let pin = UIColor(named: "color_pin")
    static let mute = UIColor(named: "color_mute")
    static let hide = UIColor(named: "color_hide")
    static let remove = UIColor(named: "color_remove")
//    class var background: UIColor? {
//        return UIColor(named: "color_background")
//    }
}

extension UIImage {
    private func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    var forUIBarButtonItem: UIImage {
        self.resized(to: CGSize(width: 23, height: 23))
    }
}
