//
//  ChatViewController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import UIKit

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        let leadingBarItem = UIBarButtonItem(title: "대화", style: .plain, target: nil, action: nil)
        leadingBarItem.tintColor = .white
        leadingBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23, weight: .black)], for: .normal)
        navigationItem.leftBarButtonItem = leadingBarItem
        
        let newChatRoomTrailingBarItem = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill")!.forUIBarButtonItem, style: .plain, target: nil, action: nil)
        newChatRoomTrailingBarItem.tintColor = .white
        let editChatListTrailingBarItem = UIBarButtonItem(image: UIImage(systemName: "list.dash")!.forUIBarButtonItem, style: .plain, target: nil, action: nil)
        editChatListTrailingBarItem.tintColor = .white
        navigationItem.rightBarButtonItems = [newChatRoomTrailingBarItem, editChatListTrailingBarItem]
        
        
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
//        (self.view.window?.rootViewController as! UITabBarController).tabBar.isHidden = true
    }
}

