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
        
        let leadingBarItem = UIBarButtonItemLabel("대화")
        navigationItem.leftBarButtonItem = leadingBarItem
        
        let newChatRoomTrailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "person.circle.fill")!)
        let editChatListTrailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "list.dash")!)
        navigationItem.rightBarButtonItems = [newChatRoomTrailingBarItem, editChatListTrailingBarItem]
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
//        (self.view.window?.rootViewController as! UITabBarController).tabBar.isHidden = true
    }
}

