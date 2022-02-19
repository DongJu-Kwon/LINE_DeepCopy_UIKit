//
//  ChatViewController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import UIKit
import Then

class ChatViewController: UIViewController {
    
    let textFieldView = CustomTextFieldView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .background
        
        let leadingBarItem = UIBarButtonItemLabel("대화")
        navigationItem.leftBarButtonItem = leadingBarItem
        
        let newChatRoomTrailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "plus.message")!)
        let editChatListTrailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "list.dash")!)
        navigationItem.rightBarButtonItems = [newChatRoomTrailingBarItem, editChatListTrailingBarItem]
        
        textFieldView.do {
            $0.textField.delegate = self
            
            self.view.addSubview($0)
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.TextField.Padding.horizontal),
                $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.TextField.Padding.horizontal),
                $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
                $0.heightAnchor.constraint(equalToConstant: Constants.TextField.ViewHeight.ifself)
            ])
        }
    }

    override func viewDidAppear(_ animated: Bool) {
//        (self.view.window?.rootViewController as! UITabBarController).tabBar.isHidden = true
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.endEditing(true)
        let searchViewController = SearchViewController().then { _ in
            
        }
        self.navigationController!.pushViewController(searchViewController, animated: false)
    }
}

