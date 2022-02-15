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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /*
         * 이 코드 안됨
         */
        
        let statusBackgroundView = UIView(frame: self.view.window!.windowScene!.statusBarManager!.statusBarFrame).then {
            $0.backgroundColor = .background
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
            
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.topAnchor),
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
        }
    }
    
    override func viewSafeAreaInsetsDidChange() {

    }
}

