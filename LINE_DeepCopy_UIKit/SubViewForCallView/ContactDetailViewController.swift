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
    
    let navigationTitleLabel = UILabel()
    let historyTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .background
        $0.allowsSelection = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let profileView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    var profileViewTopAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = self.navigationTitleLabel
        self.view.backgroundColor = .background
        
        self.view.addSubview(profileView)
        profileView.setFullWidth(target: self.view)
        profileView.setHeight(Constants.ContactDetailView.ProfileView.ViewHeight.itself)
        profileViewTopAnchor = profileView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).then {
            $0.isActive = true
        }
        
        let profileSubView = UIView().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            profileView.addSubview($0)
            $0.setHorizontalMargin(target: profileView, Constants.ContactDetailView.ProfileView.Padding.horizontal)
        }
        
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
            profileSubView.addSubview($0)
        }
        
        let friendImageView = UIImageView(image: friend.image.forContactDetailProfile).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            profileSubView.addSubview($0)
        }
        
        let chatCallButtonView = UIView().then {
            $0.layer.addSublayer(CALayer().then {
                $0.backgroundColor = UIColor.borderGray.cgColor
                $0.frame = CGRect(x: 0, y: Constants.ContactDetailView.ButtonView.ViewHeight.itself - 0.2, width: view.frame.size.width, height: 0.2)
            })
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        let toChatButton = ChatCallButton(for: .chat)
        let toVoiceCallButton = ChatCallButton(for: .voice)
        let toVideoCallButton = ChatCallButton(for: .video)
        chatCallButtonView.addSubview(toChatButton)
        chatCallButtonView.addSubview(toVoiceCallButton)
        chatCallButtonView.addSubview(toVideoCallButton)

        chatCallButtonView.setFullWidth(target: profileView)
        chatCallButtonView.setHeight(Constants.ContactDetailView.ButtonView.ViewHeight.itself)
        
        toChatButton.setWidth(view.frame.size.width/3)
        toVoiceCallButton.setWidth(view.frame.size.width/3)
        toVideoCallButton.setWidth(view.frame.size.width/3)
        toChatButton.setFullHeight(target: chatCallButtonView)
        toVoiceCallButton.setFullHeight(target: chatCallButtonView)
        toVideoCallButton.setFullHeight(target: chatCallButtonView)
        
        NSLayoutConstraint.activate([
            chatCallButtonView.topAnchor.constraint(equalTo: profileView.bottomAnchor),
            
            profileSubView.topAnchor.constraint(equalTo: profileView.topAnchor),
            profileSubView.heightAnchor.constraint(equalToConstant: Constants.ContactDetailView.ProfileView.ViewHeight.subView),
            
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
            historyTableView.delegate = self
            historyTableView.dataSource = self
            historyTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
            historyTableView.register(ContactDetailTableCell.self, forCellReuseIdentifier: "cell")
            historyTableView.tableFooterView = UIView(frame: .zero)
            historyTableView.sectionFooterHeight = 0
            historyTableView.separatorStyle = .none
                
            self.view.addSubview(historyTableView)
            historyTableView.setFullWidth(target: self.view)
                
            NSLayoutConstraint.activate([
                historyTableView.topAnchor.constraint(equalTo: chatCallButtonView.bottomAnchor),
                historyTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
        
        /*
         for debug
         */
        
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
        self.navigationTitleLabel.attributedText = NSAttributedString(string: friend.name, attributes: [
            .foregroundColor: UIColor.white.withAlphaComponent(0),
            .font: UIFont.forContactDetailNavigationTitle
        ])
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
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.indicatorStyle = .white
        print("scroll will begin dragging\t\(scrollView.contentOffset.y)")
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scroll did end dragging\t\t\(scrollView.contentOffset.y)\t\tDecelerate: \(decelerate)")
        
        if !decelerate {
            switch scrollView.contentOffset.y {
            case ...Constants.ContactDetailView.ProfileView.ViewHeight.subView:
                historyTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: true)
            case ...Constants.ContactDetailView.ProfileView.ViewHeight.itself:
                historyTableView.setContentOffset(CGPoint(x: 0, y: Constants.ContactDetailView.ProfileView.ViewHeight.itself), animated: true)
                break
            default:
                break
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.y
        
        self.navigationTitleLabel.attributedText = NSAttributedString(string: self.navigationTitleLabel.text!, attributes: [
            .foregroundColor: UIColor.white.withAlphaComponent(min(max(0, scrollPosition/Constants.ContactDetailView.ProfileView.Padding.alphaBottom), 1)),
            .font: UIFont.forContactDetailNavigationTitle
        ])
        
        switch scrollPosition {
        case ...0:
            self.profileViewTopAnchor.constant = 0
        case ...Constants.ContactDetailView.ProfileView.ViewHeight.itself:
//            self.profileViewTopAnchor.constant = -scrollPosition
            return
        default:
            return
        }
    }
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
        
        self.configuration = {
            var configuration = UIButton.Configuration.plain()
            configuration.image = image.forContactDetailButton
            configuration.attributedTitle = AttributedString(title, attributes: AttributeContainer([
                .foregroundColor: UIColor.gray,
                .font: UIFont.forContactDetailButton,
            ]))
            configuration.imagePlacement = .top
            configuration.imagePadding = Constants.ContactDetailView.ButtonView.Padding.itself
            return configuration
        }()
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
            callTypeTextLabel.leadingAnchor.constraint(equalTo: timeTextLabel.trailingAnchor, constant: Constants.ContactDetailView.TableView.Padding.callTypeTextLeading),
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
            fromTypeTextLabel.text = "부재중 전화"
            fromTypeTextLabel.textColor = .red
        case .sender(.called(let seconds)), .receiver(.called(let seconds)):
            fromTypeTextLabel.text = Date.secondsToHours(seconds: seconds)
        }
    }
}
