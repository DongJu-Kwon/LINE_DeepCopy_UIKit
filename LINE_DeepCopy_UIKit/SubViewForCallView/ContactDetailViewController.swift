//
//  ContactDetailViewController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/31.
//

import UIKit
import Then

class ContactDetailViewController: UIViewController {
    public var friend: Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .background
        self.title = friend.name
        
        let profileScrollView = UIView()
        profileScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(profileScrollView)
        
//        let historyTableView = UITableView()
//        historyTableView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(historyTableView)
        
        let profileView = UIView()
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileScrollView.addSubview(profileView)
        
        let profileSubView = UIView()
        profileSubView.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(profileSubView)
        profileSubView.setHorizontalMargin(target: profileView, Constants.ContactDetailView.ScrollView.Padding.horizontal)
        
        let friendNameLabel = UILabel().then {
            $0.attributedText = NSAttributedString(string: friend.name, attributes: [
                .paragraphStyle: NSMutableParagraphStyle().then {
                    $0.alignment = .left
                    $0.lineSpacing = 2
                    $0.lineBreakMode = .byTruncatingTail
                }
            ])
            $0.numberOfLines = 2
            $0.font = UIFont.forContactDetailProfileFriendName
            $0.textColor = .white
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        profileSubView.addSubview(friendNameLabel)
        
        let friendImageView = UIImageView(image: friend.image.forContactDetailProfileImage)
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        profileSubView.addSubview(friendImageView)
        
        let chatCallButtonView = UIView()
        let border = CALayer()
        border.backgroundColor = UIColor.borderGray!.cgColor
        border.frame = CGRect(x: 0, y: Constants.ContactDetailView.ButtonView.ViewHeight.itself - 0.2, width: view.frame.size.width, height: 0.2)
        chatCallButtonView.layer.addSublayer(border)
        chatCallButtonView.translatesAutoresizingMaskIntoConstraints = false
        profileScrollView.addSubview(chatCallButtonView)
        
        let toChatButton = ChatCallButton(for: .chat)
        let toCallButton = ChatCallButton(for: .call)
        let toFacetimeButton = ChatCallButton(for: .facetime)
        chatCallButtonView.addSubview(toChatButton)
        chatCallButtonView.addSubview(toCallButton)
        chatCallButtonView.addSubview(toFacetimeButton)
        
        profileScrollView.setFullWidth(target: view)
        profileScrollView.setHeight(Constants.ContactDetailView.ScrollView.ViewHeight.itself)
        
        profileView.setFullWidth(target: profileScrollView)
        profileView.setHeight(Constants.ContactDetailView.ProfileView.ViewHeight.itself)

        chatCallButtonView.setFullWidth(target: profileView)
        chatCallButtonView.setHeight(Constants.ContactDetailView.ButtonView.ViewHeight.itself)
        
        toChatButton.setWidth(view.frame.size.width/3)
        toCallButton.setWidth(view.frame.size.width/3)
        toFacetimeButton.setWidth(view.frame.size.width/3)
        toChatButton.setFullHeight(target: chatCallButtonView)
        toCallButton.setFullHeight(target: chatCallButtonView)
        toFacetimeButton.setFullHeight(target: chatCallButtonView)
        
        NSLayoutConstraint.activate([
            profileScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.topAnchor.constraint(equalTo: profileScrollView.topAnchor),
            chatCallButtonView.topAnchor.constraint(equalTo: profileView.bottomAnchor),
//            chatCallButtonView.topAnchor.constraint(equalTo: profileScrollView.topAnchor),
            
            profileSubView.topAnchor.constraint(equalTo: profileView.topAnchor),
            profileSubView.heightAnchor.constraint(equalToConstant: Constants.ContactDetailView.ProfileView.Padding.topAnchor*2 + Constants.ContactDetailView.ProfileView.ImageHeight.profile),
            
            friendNameLabel.centerYAnchor.constraint(equalTo: profileSubView.centerYAnchor),
            friendImageView.centerYAnchor.constraint(equalTo: profileSubView.centerYAnchor),
            
            friendNameLabel.leadingAnchor.constraint(equalTo: profileSubView.leadingAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: friendNameLabel.trailingAnchor, constant: Constants.ContactDetailView.ProfileView.Padding.imageLeading),
            friendImageView.trailingAnchor.constraint(equalTo: profileSubView.trailingAnchor),
            friendImageView.widthAnchor.constraint(equalToConstant: Constants.ContactDetailView.ProfileView.ImageHeight.profile),
            
            toChatButton.centerYAnchor.constraint(equalTo: chatCallButtonView.centerYAnchor),
            toCallButton.centerYAnchor.constraint(equalTo: chatCallButtonView.centerYAnchor),
            toFacetimeButton.centerYAnchor.constraint(equalTo: chatCallButtonView.centerYAnchor),
            
            toChatButton.leadingAnchor.constraint(equalTo: chatCallButtonView.leadingAnchor),
            toCallButton.leadingAnchor.constraint(equalTo: toChatButton.trailingAnchor),
            toFacetimeButton.leadingAnchor.constraint(equalTo: toCallButton.trailingAnchor),
            toFacetimeButton.trailingAnchor.constraint(equalTo: chatCallButtonView.trailingAnchor)
        ])
        
        /*
         for debug
         */
        
//        profileScrollView.backgroundColor = .red
//        profileView.backgroundColor = .green
//        profileSubView.backgroundColor = .purple
//        friendNameLabel.backgroundColor = .orange
//        friendImageView.backgroundColor = .yellow
//        chatCallButtonView.backgroundColor = .blue
        
        /*
         end for debug
         */
    }
    
    @objc func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ContactDetailViewController: UITextFieldDelegate {
    
}

extension ContactDetailViewController: UITableViewDelegate {
    
}
//extension ContactDetailViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//}

class ChatCallButton: UIButton {
    enum type {
        case chat
        case call
        case facetime
    }
    
    init(for type: type) {
        super.init(frame: .zero)
        
        var image = UIImage()
        var title = ""
        
        switch type {
        case .chat:
            image = UIImage(systemName: "message.fill")!
            title = "대화"
        case .call:
            image = UIImage(systemName: "phone.fill")!
            title = "음성통화"
        case .facetime:
            image = UIImage(systemName: "video.fill")!
            title = "영상통화"
        }
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = image.forContactDetailButtonImage
        configuration.attributedTitle = AttributedString(title, attributes: AttributeContainer([
            .font: UIFont.forContactDetailButton,
            .foregroundColor: UIColor.gray
        ]))
        configuration.imagePlacement = .top
        configuration.imagePadding = Constants.ContactDetailView.ButtonView.Padding.itself
        
        self.configuration = configuration
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
