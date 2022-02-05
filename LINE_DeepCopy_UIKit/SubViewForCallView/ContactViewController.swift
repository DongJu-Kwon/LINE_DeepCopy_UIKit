//
//  ContactViewController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/19.
//

import UIKit
import Then

class ContactViewController: UIViewController {
    
    let textFieldView = CustomTextFieldView(forContactView: true)
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .background
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background

        /*
         statusBarView 가 있어야 tableView가 아래로 scroll 할 때
         navigationBar 의 색상이 변하지 않음
         statusBarView 의 frame = .zero 이며 view 에 아무런 영향도 미치지 않을텐데
         도대체 영문을 모르겠음
         */
        
        let statusBarView = UIView(frame: .zero)
        view.addSubview(statusBarView)
        
        self.title = "연락처"
//        let titleLabel = UILabel()
//        let attributes: [NSString : AnyObject] = [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: colour, NSKernAttributeName : 5.0]
//        titleLabel.attributedText = NSAttributedString(string: "My String", attributes: [
//
//        ])
//        titleLabel.sizeToFit()
//        self.navigationItem.titleView = titleLabel
        
//        navigationBar.tintColor = .white
//        navigationBar.barTintColor = .gray
//        navigationBar.backgroundColor = .green
//        print(self.navigationBar.frame.height)
        
        let trailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "xmark")!.forNavigationBarXmark, defaultHeight: false)
        navigationItem.rightBarButtonItem = trailingBarItem
        
        trailingBarItem.button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        navigationItem.backButtonDisplayMode = .minimal
        
        textFieldView.textField.delegate = self
        view.addSubview(textFieldView)
        textFieldView.setHorizontalMargin(target: view, Constants.TextField.Margin.horizontal)
        textFieldView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        textFieldView.setHeight(Constants.TextField.ViewHeight.ifself)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(ContactTableCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        tableView.setFullWidth(target: view)
        tableView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
}

extension ContactViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ContactViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return FriendList.shared.sortedFriendWithKey.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.ContactView.ViewHeight.section
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView().then {
            let label = UILabel().then {
                $0.text = FriendList.shared.sortedFriendWithKey[section].0
                $0.textColor = .white
                $0.font = .forContactTableSection
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
            $0.addSubview(label)
            NSLayoutConstraint.activate([
                label.centerYAnchor.constraint(equalTo: $0.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: Constants.ContactView.Padding.sectionLeading),
            ])
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contactDetailViewController = ContactDetailViewController().then {
            $0.setFriend(with: FriendList.shared.sortedFriendWithKey[indexPath.section].1[indexPath.row])
        }
        self.navigationController?.pushViewController(contactDetailViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.ContactView.ViewHeight.cell
    }
}
extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendList.shared.sortedFriendWithKey[section].1.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (tableView.dequeueReusableCell(withIdentifier: "cell") as! ContactTableCell).then {
            let friend = FriendList.shared.sortedFriendWithKey[indexPath.section].1[indexPath.row]
            $0.profileImageView.image = friend.image.forContactCellProfile
            $0.profileNameLabel.text = friend.name
            
            $0.backgroundColor = .background
            $0.selectedBackgroundView = UIView().then {
                $0.backgroundColor = .selectedGray
            }
        }
    }
}

class ContactTableCell: UITableViewCell {
    let profileImageView = ProfileWithLineImageView()
    let profileNameLabel = UILabel().then {
        $0.attributedText = NSAttributedString(string: "", attributes: [.paragraphStyle: NSMutableParagraphStyle().then {
            $0.alignment = .left
            $0.lineBreakMode = .byTruncatingTail
        }])
        $0.numberOfLines = 1
        $0.font = .forContactTableCellName
        $0.textColor = .white
        
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
//    let callImageView = UIImageView().then {
//        $0.tintColor = .gray
//        $0.translatesAutoresizingMaskIntoConstraints = false
//    }
    let callButton = UIButton().then {
        let callButtonImage = UIImage(systemName: "phone")!.forContactCellCall
        $0.setImage(callButtonImage, for: .normal)
        $0.setImage(callButtonImage, for: .highlighted)
        $0.tintColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(profileNameLabel)
        contentView.addSubview(callButton)
        
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            profileNameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            callButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.ContactView.Padding.profileImageLeading),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.ContactView.Padding.profileNameLeading),
            callButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Constants.ContactView.Padding.callButtonTrailing),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
