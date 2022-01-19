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
        
        let informTitleLabel = InformTitleLabel("지금 LINE 음성통화를 사용해 보세요.")
        self.view.addSubview(informTitleLabel)
        
        let informContentLabel = InformContentLabel("LINE 음성통화로 언제 어디서나 친구와 대화를 나눌 수 있습니다.")
        self.view.addSubview(informContentLabel)
        
        let informButton = InformButton("연락처에서 전화하기")
        self.view.addSubview(informButton)
        
        informButton.setCenter(target: self.view)
        informButton.setWidth(132)
        informButton.setHeight(36)
        
        informContentLabel.setBottomMargin(target: informButton, 18)
        informContentLabel.setHorizontalMargin(target: self.view, 48)
        
        informTitleLabel.setBottomMargin(target: informContentLabel, 5)
        informTitleLabel.setHorizontalMargin(target: self.view, 0)
        
        let leadingBarItem = UIBarButtonItemLabel("통화")
        navigationItem.leftBarButtonItem = leadingBarItem
        
        let trailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "person.circle")!)
        navigationItem.rightBarButtonItem = trailingBarItem
        
        informButton.addTarget(self, action: #selector(presentContactView), for: .touchUpInside)
        (trailingBarItem.customView as! UIButton).addTarget(self, action: #selector(presentContactView), for: .touchUpInside)
    }
    
    @objc func presentContactView() {
        print("1")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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

extension InformButton: Margin {}
