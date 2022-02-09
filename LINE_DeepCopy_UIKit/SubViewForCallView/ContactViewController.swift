//
//  ContactViewController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/19.
//

import UIKit
import Then

class ContactViewController: UIViewController {
    
    let textFieldView = ContactTextFieldView()
    var textFieldViewTrailingAnthor: NSLayoutConstraint!
    
    let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel!.font = .forContactCancelButton
        
        $0.layer.cornerRadius = 2.0
        $0.backgroundColor = .gray
        $0.setBackgroundColor(color: .selectedGray, forState: .highlighted)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    var cancelButtonLeadingAnthor: NSLayoutConstraint!
    
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
        self.view.addSubview(statusBarView)
        
        self.title = "연락처"
        
        let trailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "xmark")!.forNavigationBarXmark, defaultHeight: false)
        navigationItem.rightBarButtonItem = trailingBarItem
        
        trailingBarItem.button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        navigationItem.backButtonDisplayMode = .minimal
        
        textFieldView.textField.delegate = self
        self.view.addSubview(textFieldView)
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constants.TextField.Padding.top),
            textFieldView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.TextField.Padding.horizontal)
        ])
        self.textFieldViewTrailingAnthor = textFieldView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.TextField.Padding.horizontal).then {
            $0.isActive = true
        }
        textFieldView.setHeight(Constants.TextField.ViewHeight.ifself)
        
        self.cancelButton.addTarget(self, action: #selector(hideCancelButton), for: .touchUpInside)
        self.view.addSubview(cancelButton)
        self.cancelButtonLeadingAnthor = cancelButton.leadingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: Constants.ContactView.Padding.cancelButtonLeadingBeforeShowing).then {
            $0.isActive = true
        }
        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: Constants.ContactView.ViewWidth.cancelButton),
            cancelButton.heightAnchor.constraint(equalToConstant: Constants.ContactView.ViewHeight.cancelButton),
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(ContactTableCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        tableView.setFullWidth(target: view)
        tableView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func showCancelButton() {
        self.textFieldViewTrailingAnthor.constant = Constants.ContactView.Padding.textFieldViewTrailingAfterShowing
        self.cancelButtonLeadingAnthor.constant = Constants.ContactView.Padding.cancelButtonLeadingAfterShowing
        UIView.animate(withDuration: 0.2, delay: 0, options: []) {
            self.view.layoutIfNeeded()
        }
        self.navigationController!.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func hideCancelButton() {
        self.textFieldViewTrailingAnthor.constant = -Constants.TextField.Padding.horizontal
        self.cancelButtonLeadingAnthor.constant = Constants.ContactView.Padding.cancelButtonLeadingBeforeShowing
        UIView.animate(withDuration: 0.2, delay: 0, options: []) {
            self.view.layoutIfNeeded()
        }
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.view.endEditing(true)
        self.textFieldView.textField.text = ""
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
}

extension ContactViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.showCancelButton()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.hideCancelButton()
        print("TextField Did End Editing")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("TextField Should Return")
        return true
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.ContactView.ViewHeight.cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.hideCancelButton()
        
        let contactDetailViewController = ContactDetailViewController().then {
            $0.setFriend(with: FriendList.shared.sortedFriendWithKey[indexPath.section].1[indexPath.row])
        }
        self.navigationController!.pushViewController(contactDetailViewController, animated: true)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if self.textFieldView.textField.text!.isEmpty {
            self.hideCancelButton()
            print("ScrollView Will Begin Dragging")
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.restoreNavigationBar()
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

class ContactTextFieldView: CustomTextFieldView {
    override init() {
        super.init()
        
        barcodeImageView.removeFromSuperview()
        
        textFieldTrailingAnthor.isActive = false
        textFieldTrailingAnthor = textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).then {
            $0.isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
