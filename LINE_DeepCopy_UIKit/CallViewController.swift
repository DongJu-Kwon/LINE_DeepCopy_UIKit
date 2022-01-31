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
        print(UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? -1
        )
        print(self.navigationController?.navigationBar.frame.height)
        
        self.view.backgroundColor = .background
        
        let informButton = InformButton("연락처에서 전화하기").then {
            self.view.addSubview($0)
            $0.setCenter(target: self.view)
            $0.setWidth(132)
            $0.setHeight(36)
        }
        
        let informContentLabel = InformContentLabel("LINE 음성통화로 언제 어디서나 친구와 대화를 나눌 수 있습니다.").then {
            self.view.addSubview($0)
            $0.setBottomMargin(target: informButton, 18)
            $0.setHorizontalMargin(target: self.view, 48)
        }
        
        let informTitleLabel = InformTitleLabel("지금 LINE 음성통화를 사용해 보세요.").then {
            self.view.addSubview($0)
            $0.setBottomMargin(target: informContentLabel, 5)
            $0.setHorizontalMargin(target: self.view, 0)
        }
        
        let leadingBarItem = UIBarButtonItemLabel("통화")
        navigationItem.leftBarButtonItem = leadingBarItem
        
        let trailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "person.circle")!)
        navigationItem.rightBarButtonItem = trailingBarItem
        
        informButton.addTarget(self, action: #selector(presentContactView), for: .touchUpInside)
        trailingBarItem.button.addTarget(self, action: #selector(presentContactView), for: .touchUpInside)
    }
    
    @objc func presentContactView() {
//        let callViewController = ContactViewController()
//        callViewController.modalPresentationStyle = .overFullScreen
//        present(callViewController, animated: true)
        
        let callViewController = CustomNavigationController(rootViewController: ContactViewController()).then {
            $0.modalPresentationStyle = .overFullScreen
        }
        present(callViewController, animated: true)
        
    }
}

private class InformTitleLabel: CustomLabel {
    override init(_ string: String) {
        super.init(string)
        
        self.font = .forInformTitle
        self.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class InformContentLabel: CustomLabel {
    override init(_ string: String) {
        super.init(string)
        
        self.font = .forInformContent
        self.textColor = .gray
        self.numberOfLines = 2
//        self.lineBreakMode = .byTruncatingTail
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class InformButton: UIButton {
    init(_ string: String) {
        super.init(frame: CGRect.zero)
        
        self.setTitle(string, for: .normal)
        self.titleLabel!.font = .forInformButton
        
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.3
        self.layer.borderColor = UIColor.borderGray!.cgColor
        
        self.backgroundColor = .background
        self.setBackgroundColor(color: .selectedGray!, forState: .highlighted)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}

