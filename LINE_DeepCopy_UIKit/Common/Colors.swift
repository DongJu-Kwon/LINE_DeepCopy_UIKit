//
//  Colors.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/19.
//

import UIKit

extension UIColor {
    static let background = UIColor(named: "color_background")!
    static let gray = UIColor(named: "color_gray")!
    static let borderGray = UIColor(named: "color_gray_border")!
    static let selectedGray = UIColor(named: "color_gray_selected")!
    
    static let pin = UIColor(named: "color_pin")
    static let mute = UIColor(named: "color_mute")
    static let hide = UIColor(named: "color_hide")
    static let remove = UIColor(named: "color_remove")
    
    static let random = UIColor(red: .random(in: 0.1...0.3), green: .random(in: 0.1...0.3), blue: .random(in: 0.1...0.3), alpha: 1)
}
