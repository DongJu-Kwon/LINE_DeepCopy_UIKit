//
//  CustomNavigationController.swift.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .background
        navigationBar.isTranslucent = false
//        navigationBar.barTintColor = .background
        navigationBar.barStyle = UIBarStyle.black
        
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.forNavigationTitle]
    }
}
