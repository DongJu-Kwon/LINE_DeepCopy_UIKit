//
//  VoomViewController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import UIKit

class VoomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        let leadingBarItem = UIBarButtonItemLabel("LINE VOOM")
        navigationItem.leftBarButtonItem = leadingBarItem
        
        let trailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "person.circle.fill")!)
        navigationItem.rightBarButtonItem = trailingBarItem
    }

    @objc func presentContactView() {
        
    }
}

