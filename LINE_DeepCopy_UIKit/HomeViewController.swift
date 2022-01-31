//
//  HomeViewController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .background
        let profileImageLeadingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "person.circle.fill")!.forProfileUIBarButtonItem, defaultHeight: false)
        let profileNicknameLeadingBarIten = UIBarButtonItemLabel("temp", isProfile: true)
        navigationItem.leftBarButtonItems = [profileImageLeadingBarItem, profileNicknameLeadingBarIten]
        
        let settingTrailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "gearshape")!)
        let addFriendTrailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "person.badge.plus")!)
        let notificationTrailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "bell")!)
        navigationItem.rightBarButtonItems = [settingTrailingBarItem, addFriendTrailingBarItem, notificationTrailingBarItem]
        
        
    }
    
    override func viewSafeAreaInsetsDidChange() {

    }


}

