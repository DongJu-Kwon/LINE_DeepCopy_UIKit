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
        
        let leadingBarItem = UIBarButtonItem(title: "LINE VOOM", style: .plain, target: nil, action: nil)
        leadingBarItem.tintColor = .white
        leadingBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23, weight: .black)], for: .normal)
        navigationItem.leftBarButtonItem = leadingBarItem
        
        let trailingBarItem = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill")!.forUIBarButtonItem, style: .plain, target: self, action: #selector(presentContactView))
        trailingBarItem.tintColor = .white
        navigationItem.rightBarButtonItem = trailingBarItem
    }

    @objc func presentContactView() {
        
    }
}

