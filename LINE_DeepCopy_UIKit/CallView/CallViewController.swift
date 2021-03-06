//
//  CallViewController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import UIKit
import Then

fileprivate var friendsWhoHaveCallHistory: [Friend] = []

class CallViewController: UIViewController {
    let tableView = UITableView(frame: .zero).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .background
        
        let leadingBarItem = UIBarButtonItemLabel("통화")
        navigationItem.leftBarButtonItem = leadingBarItem
        
        let trailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "person.circle")!)
        trailingBarItem.button.addTarget(self, action: #selector(presentContactView), for: .touchUpInside)
        navigationItem.rightBarButtonItem = trailingBarItem
        
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(CallTableCell.self, forCellReuseIdentifier: "cell")
            $0.separatorStyle = .none
            $0.backgroundColor = .background
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateFriendsWhoHaveCallHistory()
        updateLayout()
    }
    
    func updateFriendsWhoHaveCallHistory() {
        friendsWhoHaveCallHistory = FriendManager.shared.friendArray.filter {
            !$0.callHistory.isEmpty
        }.sorted {
            $0.lastCallHistroy!.timestamp > $1.lastCallHistroy!.timestamp
        }
    }
    
    func updateLayout() {
        self.view.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        if friendsWhoHaveCallHistory.isEmpty {
            let informButton = InformButton("연락처에서 전화하기").then {
                self.view.addSubview($0)
                NSLayoutConstraint.activate([
                    $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    $0.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    $0.widthAnchor.constraint(equalToConstant: 132),
                    $0.heightAnchor.constraint(equalToConstant: 36),
                ])
            }
            
            let informContentLabel = InformContentLabel("LINE 음성통화로 언제 어디서나 친구와 대화를 나눌 수 있습니다.").then {
                self.view.addSubview($0)
                NSLayoutConstraint.activate([
                    $0.bottomAnchor.constraint(equalTo: informButton.topAnchor, constant: -18),
                    $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48),
                    $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48)
                ])
            }
            
            let _/*informTitleLabel*/ = InformTitleLabel("지금 LINE 음성통화를 사용해 보세요.").then {
                self.view.addSubview($0)
                NSLayoutConstraint.activate([
                    $0.bottomAnchor.constraint(equalTo: informContentLabel.topAnchor, constant: 5),
                    $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                ])
            }
            
            informButton.addTarget(self, action: #selector(presentContactView), for: .touchUpInside)
        } else {
            tableView.do {
                self.view.addSubview($0)
                NSLayoutConstraint.activate([
                    $0.topAnchor.constraint(equalTo: self.view.topAnchor),
                    $0.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                    $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                ])
            }
        }
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

extension CallViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contactDetailViewController = ContactDetailViewController().then {
            $0.setFriend(with: friendsWhoHaveCallHistory[indexPath.row])
        }
        self.navigationController?.pushViewController(contactDetailViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.CallView.ViewHeight.cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            friendsWhoHaveCallHistory[indexPath.row].callHistory.removeAll()
            self.updateFriendsWhoHaveCallHistory()
            if friendsWhoHaveCallHistory.isEmpty {
                self.updateLayout()
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
extension CallViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsWhoHaveCallHistory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (tableView.dequeueReusableCell(withIdentifier: "cell") as! CallTableCell).then {
            let friend = friendsWhoHaveCallHistory[indexPath.row]
            $0.setInformation(with: friend)
            
            $0.backgroundColor = .background
            $0.selectedBackgroundView = UIView().then {
                $0.backgroundColor = .selectedGray
            }
        }
    }
}

private class InformTitleLabel: CustomLabel {
    override init(_ string: String) {
        super.init(string)
        
        self.font = .forCallViewInformTitle
        self.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class InformContentLabel: CustomLabel {
    override init(_ string: String) {
        super.init(string)
        
        self.font = .forCallViewInformContent
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
        self.titleLabel!.font = .forCallViewInformButton
        
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.3
        self.layer.borderColor = UIColor.borderGray.cgColor
        
        self.backgroundColor = .background
        self.setBackgroundColor(color: .selectedGray, forState: .highlighted)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CallTableCell: UITableViewCell {
    let profileImageView = ProfileWithLineImageView()
    let informationView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let profileNameLabel = UILabel().then {
        $0.attributedText = NSAttributedString(string: "", attributes: [.paragraphStyle: NSMutableParagraphStyle().then {
            $0.alignment = .left
        }])
        $0.numberOfLines = 1
        $0.font = .forCallCellName
        $0.textColor = .white
        
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let historyCountLabel = UILabel().then {
        $0.attributedText = NSAttributedString(string: "", attributes: [.paragraphStyle: NSMutableParagraphStyle().then {
            $0.alignment = .right
        }])
        $0.numberOfLines = 1
        $0.font = .forCallCellName
        $0.textColor = .white
        
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let callFromImageView = UIImageView().then {
        $0.tintColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let callDateLabel = UILabel().then {
        $0.attributedText = NSAttributedString(string: "", attributes: [.paragraphStyle: NSMutableParagraphStyle().then {
            $0.alignment = .left
        }])
        $0.textColor = .gray
        $0.font = .forCallCellDate
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let callButton = UIButton().then {
        $0.tintColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let voiceButtonImage = UIImage(systemName: "phone")!.forCallCellCall
    let videoButtonImage = UIImage(systemName: "video")!.forCallCellCall
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(informationView)
        informationView.addSubview(profileNameLabel)
        informationView.addSubview(historyCountLabel)
        informationView.addSubview(callFromImageView)
        informationView.addSubview(callDateLabel)
        contentView.addSubview(callButton)
        
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            informationView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            callButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.CallView.Padding.profileImageLeading),
            informationView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.CallView.Padding.informationLeading),
            informationView.trailingAnchor.constraint(equalTo: callButton.leadingAnchor, constant: Constants.CallView.Padding.informationTrailing),
            callButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Constants.CallView.Padding.callButtonTrailing),
            
            profileNameLabel.topAnchor.constraint(equalTo: informationView.topAnchor),
            profileNameLabel.leadingAnchor.constraint(equalTo: informationView.leadingAnchor),
            historyCountLabel.topAnchor.constraint(equalTo: informationView.topAnchor),
            
            callFromImageView.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: Constants.CallView.Padding.profileNameBottom),
            callFromImageView.leadingAnchor.constraint(equalTo: informationView.leadingAnchor),
            callFromImageView.bottomAnchor.constraint(equalTo: informationView.bottomAnchor),
            callDateLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: Constants.CallView.Padding.profileNameBottom),
            callDateLabel.leadingAnchor.constraint(equalTo: callFromImageView.trailingAnchor, constant: Constants.CallView.Padding.callDateLeading),
            callDateLabel.bottomAnchor.constraint(equalTo: informationView.bottomAnchor),
        ])
        
        /*
         * for debug
         */
        
//        profileImageView.backgroundColor = .red
//        informationView.backgroundColor = .orange
//        callImageView.backgroundColor = .yellow
//        profileNameLabel.backgroundColor = .green
//        historyCountLabel.backgroundColor = .magenta
//        callFromImageView.backgroundColor = .blue
//        callDateLabel.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInformation(with friend: Friend) {
        let lastCallHistory = friend.lastCallHistroy!
        let callHistoryCount = friend.callHistory.count
        var profileName = friend.name
        var nameChanged = false
        
        profileImageView.image = friend.image.forCallCellProfile
        historyCountLabel.text = callHistoryCount > 1 ? "(\(callHistoryCount))" : ""
        profileNameLabel.text = {
            while ( "\(profileName)\(nameChanged ? "⋯": "")" as NSString).size(withAttributes: [:]).width > 220 - historyCountLabel.intrinsicContentSize.width {
                profileName.removeLast()
                nameChanged = true
            }
            return  "\(profileName)\(nameChanged ? "⋯": "")"
        }()
        
        if nameChanged {
            historyCountLabel.trailingAnchor.constraint(equalTo: informationView.trailingAnchor, constant: Constants.CallView.Padding.historyCountTrailing).isActive = true
        } else {
            historyCountLabel.leadingAnchor.constraint(equalTo: profileNameLabel.trailingAnchor, constant: Constants.CallView.Padding.historyCountLeading).isActive = true
        }
        
        if case .receiver(.missed) = lastCallHistory.fromType {
            profileNameLabel.textColor = .red
        }
        switch lastCallHistory.fromType {
        case .sender(_):
            callFromImageView.image = UIImage(systemName: "arrow.up.right")!.forCallCellFrom
        case .receiver(_):
            callFromImageView.image = UIImage(systemName: "arrow.down.backward")!.forCallCellFrom
        }
        
        switch lastCallHistory.timestamp {
        case ..<Calendar.current.date(byAdding: .day, value: -6, to: Date().startOfDay)!:
            callDateLabel.text = lastCallHistory.timestamp.monthAndDaysWithKST
        case ..<Date().startOfDay:
            callDateLabel.text = lastCallHistory.timestamp.weekday
        default:
            callDateLabel.text = lastCallHistory.timestamp.filterBeforeHoursWithKST
        }
        switch lastCallHistory.callType {
        case .voice:
            callButton.setImage(voiceButtonImage, for: .normal)
            callButton.setImage(voiceButtonImage, for: .highlighted)
        case .video:
            callButton.setImage(videoButtonImage, for: .normal)
            callButton.setImage(videoButtonImage, for: .highlighted)
        }
    }
}
