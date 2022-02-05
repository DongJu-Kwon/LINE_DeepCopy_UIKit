//
//  ContactDetailViewController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/31.
//

import UIKit
import Then

fileprivate unowned var friend: Friend!

class ContactDetailViewController: UIViewController {
    public var fromCallView: Bool! = false
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .background
        $0.allowsSelection = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
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
        
        let friendImageView = UIImageView(image: friend.image.forContactDetailProfile)
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        profileSubView.addSubview(friendImageView)
        
        let chatCallButtonView = UIView()
        let border = CALayer().then {
            $0.backgroundColor = UIColor.borderGray.cgColor
            $0.frame = CGRect(x: 0, y: Constants.ContactDetailView.ButtonView.ViewHeight.itself - 0.2, width: view.frame.size.width, height: 0.2)
        }
        chatCallButtonView.layer.addSublayer(border)
        chatCallButtonView.translatesAutoresizingMaskIntoConstraints = false
        profileScrollView.addSubview(chatCallButtonView)
        
        let toChatButton = ChatCallButton(for: .chat)
        let toVoiceCallButton = ChatCallButton(for: .voice)
        let toVideoCallButton = ChatCallButton(for: .video)
        chatCallButtonView.addSubview(toChatButton)
        chatCallButtonView.addSubview(toVoiceCallButton)
        chatCallButtonView.addSubview(toVideoCallButton)
        
        profileScrollView.setFullWidth(target: view)
        profileScrollView.setHeight(Constants.ContactDetailView.ScrollView.ViewHeight.itself)
        
        profileView.setFullWidth(target: profileScrollView)
        profileView.setHeight(Constants.ContactDetailView.ProfileView.ViewHeight.itself)

        chatCallButtonView.setFullWidth(target: profileView)
        chatCallButtonView.setHeight(Constants.ContactDetailView.ButtonView.ViewHeight.itself)
        
        toChatButton.setWidth(view.frame.size.width/3)
        toVoiceCallButton.setWidth(view.frame.size.width/3)
        toVideoCallButton.setWidth(view.frame.size.width/3)
        toChatButton.setFullHeight(target: chatCallButtonView)
        toVoiceCallButton.setFullHeight(target: chatCallButtonView)
        toVideoCallButton.setFullHeight(target: chatCallButtonView)
        
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
            toVoiceCallButton.centerYAnchor.constraint(equalTo: chatCallButtonView.centerYAnchor),
            toVideoCallButton.centerYAnchor.constraint(equalTo: chatCallButtonView.centerYAnchor),
            
            toChatButton.leadingAnchor.constraint(equalTo: chatCallButtonView.leadingAnchor),
            toVoiceCallButton.leadingAnchor.constraint(equalTo: toChatButton.trailingAnchor),
            toVideoCallButton.leadingAnchor.constraint(equalTo: toVoiceCallButton.trailingAnchor),
            toVideoCallButton.trailingAnchor.constraint(equalTo: chatCallButtonView.trailingAnchor)
        ])
        
        if self.fromCallView {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
            tableView.register(ContactDetailTableCell.self, forCellReuseIdentifier: "cell")
            tableView.tableFooterView = UIView(frame: .zero)
            tableView.sectionFooterHeight = 0
            tableView.separatorStyle = .none
                
            self.view.addSubview(tableView)
            tableView.setFullWidth(target: self.view)
                
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: profileScrollView.bottomAnchor),
                tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        }
        
        /*
         for debug
         */
        
//        profileScrollView.backgroundColor = .red
//        profileView.backgroundColor = .green
//        profileSubView.backgroundColor = .purple
//        friendNameLabel.backgroundColor = .orange
//        friendImageView.backgroundColor = .yellow
//        chatCallButtonView.backgroundColor = .blue
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setFriend(with: Friend) {
        friend = with
    }
    
    func flashScrollbar() {
        self.tableView.flashScrollIndicators()
    }
    
    @objc func dismissView() {
        self.navigationController!.popViewController(animated: true)
    }
}

extension ContactDetailViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return friend.sortedCallHistoryWithKey.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.ContactDetailView.TableView.ViewHeight.section
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView().then {
            let label = UILabel().then {
                $0.text = friend.sortedCallHistoryWithKey[section].0 == Date().startOfDay ? "오늘" : friend.sortedCallHistoryWithKey[section].0.dropAfterDaysWithKST
                $0.textColor = .white
                $0.font = .forContactDetailTableSection
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
            $0.addSubview(label)
            NSLayoutConstraint.activate([
                label.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: Constants.ContactDetailView.TableView.Padding.sectionBottom),
                label.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: Constants.ContactDetailView.TableView.Padding.sectionLeading),
                label.trailingAnchor.constraint(equalTo: $0.trailingAnchor),
            ])
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.ContactDetailView.TableView.ViewHeight.cell
    }
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        scrollView.indicatorStyle = .default
//        self.flashScrollbar()
//        print(scrollView.frame)
//    }
}
extension ContactDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friend.sortedCallHistoryWithKey[section].1.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (tableView.dequeueReusableCell(withIdentifier: "cell") as! ContactDetailTableCell).then {
            $0.setInformation(with: friend.sortedCallHistoryWithKey[indexPath.section].1[indexPath.row])
            $0.backgroundColor = .background
        }
    }
}

class ChatCallButton: UIButton {
    enum type {
        case chat
        case voice
        case video
    }
    
    init(for type: type) {
        super.init(frame: .zero)
        
        var image = UIImage()
        var title = ""
        
        switch type {
        case .chat:
            image = UIImage(systemName: "message.fill")!
            title = "대화"
        case .voice:
            image = UIImage(systemName: "phone.fill")!
            title = "음성통화"
        case .video:
            image = UIImage(systemName: "video.fill")!
            title = "영상통화"
        }
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = image.forContactDetailButton
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

class ContactDetailTableCell: UITableViewCell {
    let callFromImageView = UIImageView().then {
        $0.tintColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let timeTextLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.forContactDetailTableCell
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let callTypeTextLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = UIFont.forContactDetailTableCell
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let fromTypeTextLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.forContactDetailTableCell
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(callFromImageView)
        contentView.addSubview(timeTextLabel)
        contentView.addSubview(callTypeTextLabel)
        contentView.addSubview(fromTypeTextLabel)
        
        NSLayoutConstraint.activate([
            callFromImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            timeTextLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            callTypeTextLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            fromTypeTextLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            callFromImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.ContactDetailView.TableView.Padding.callFromImageLeading),
            timeTextLabel.leadingAnchor.constraint(equalTo: callFromImageView.trailingAnchor, constant: Constants.ContactDetailView.TableView.Padding.timeTextLeading),
            timeTextLabel.widthAnchor.constraint(equalToConstant: Constants.ContactDetailView.TableView.ViewWidth.timeText),
            callTypeTextLabel.leadingAnchor.constraint(equalTo: timeTextLabel.trailingAnchor, constant: Constants.ContactDetailView.TableView.Padding.callTypeTextLeading),
            callTypeTextLabel.widthAnchor.constraint(equalToConstant: Constants.ContactDetailView.TableView.ViewWidth.callTypeText),
            fromTypeTextLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Constants.ContactDetailView.TableView.Padding.fromTypeTextTrailing)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInformation(with: Friend.CallHistory) {
        switch with.fromType {
        case .sender(_):
        callFromImageView.image = UIImage(systemName: "arrow.up.right")!.forContactDetailFrom
        case .receiver(_):
        callFromImageView.image = UIImage(systemName: "arrow.down.backward")!.forContactDetailFrom
        }
        timeTextLabel.text = with.date.filterBeforeHoursWithKST
        callTypeTextLabel.text = "\(with.callType == .voice ? "음성" : "영상")통화"
        switch with.fromType {
        case .sender(.cancelled):
            fromTypeTextLabel.text = "취소된 통화"
        case .receiver(.missed):
            fromTypeTextLabel.text = "부재중"
        case .sender(.called(let seconds)), .receiver(.called(let seconds)):
            fromTypeTextLabel.text = Date.secondsToHours(seconds: seconds)
        }
    }
}
