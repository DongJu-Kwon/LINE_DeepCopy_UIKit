//
//  CallViewController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import UIKit

class CallViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        let informLargeText = UILabel()
        informLargeText.text = "지금 LINE 음성통화를 사용해 보세요."
        informLargeText.textColor = .white
        self.view.addSubview(informLargeText)
        
        informLargeText.translatesAutoresizingMaskIntoConstraints = false
        informLargeText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        informLargeText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        informLargeText.heightAnchor.constraint(equalToConstant: 200).isActive = true
        informLargeText.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        let informText = UILabel()
        informText.text = "LINE 음성통화로 언제 어디서나 친구와 대화를 나눌\n수 있습니다."
        informText.textColor = .white
        self.view.addSubview(informText)
        
        informText.translatesAutoresizingMaskIntoConstraints = false
        informText.topAnchor.constraint(equalTo: informLargeText.bottomAnchor, constant: 10).isActive = true
        informText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        informText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
//        informText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        informText.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        informText.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let leadingBarItem = UIBarButtonItem(title: "통화", style: .plain, target: nil, action: nil)
        leadingBarItem.tintColor = .white
        leadingBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23, weight: .black)], for: .normal)
        navigationItem.leftBarButtonItem = leadingBarItem
        
        let trailingBarItem = UIBarButtonItem(image: UIImage(systemName: "person.circle")!.forUIBarButtonItem, style: .plain, target: self, action: #selector(presentContactView))
        trailingBarItem.tintColor = .white
        navigationItem.rightBarButtonItem = trailingBarItem
    }
    
    @objc func presentContactView() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
}
