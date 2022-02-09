//
//  ChatViewController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import UIKit

class ChatViewController: UIViewController {
    
    let textFieldView = CustomTextFieldView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        let leadingBarItem = UIBarButtonItemLabel("대화")
        navigationItem.leftBarButtonItem = leadingBarItem
        
        let newChatRoomTrailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "person.circle.fill")!)
        let editChatListTrailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "list.dash")!)
        navigationItem.rightBarButtonItems = [newChatRoomTrailingBarItem, editChatListTrailingBarItem]
        
        textFieldView.textField.delegate = self
        view.addSubview(textFieldView)
        textFieldView.setHorizontalMargin(target: view, Constants.TextField.Padding.horizontal)
        textFieldView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        textFieldView.setHeight(Constants.TextField.ViewHeight.ifself)
        
    }

    override func viewDidAppear(_ animated: Bool) {
//        (self.view.window?.rootViewController as! UITabBarController).tabBar.isHidden = true
    }
}

extension ChatViewController: UITextFieldDelegate {
    
}

