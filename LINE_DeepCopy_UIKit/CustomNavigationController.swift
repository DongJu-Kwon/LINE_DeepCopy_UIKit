//
//  CustomNavigationController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import UIKit
import Then

class CustomNavigationController: UINavigationController {
    
    var statusBarBackgroundViewDidMake = false
    
    override func viewDidLoad() {
        
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .background
        navigationBar.isTranslucent = false
//        navigationBar.barTintColor = .background
        navigationBar.barStyle = UIBarStyle.black
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if self.statusBarBackgroundViewDidMake {
            return
        }
        
        let _ = UIView().then {
            $0.backgroundColor = .background
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)

            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.topAnchor),
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                $0.widthAnchor.constraint(equalTo: view.widthAnchor),
                $0.heightAnchor.constraint(equalToConstant: UIApplication.shared.connectedScenes.flatMap {
                    ($0 as! UIWindowScene).windows
                }.first {
                    $0.isKeyWindow
                }!.windowScene!.statusBarManager!.statusBarFrame.height)
            ])
        }
        
        self.statusBarBackgroundViewDidMake = true
    }
}
