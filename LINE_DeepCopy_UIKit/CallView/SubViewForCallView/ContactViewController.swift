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
    
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .background
        $0.separatorStyle = .none
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let searchedTableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .background
        $0.sectionHeaderHeight = 0
        $0.separatorStyle = .none
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let notFoundView = UIScrollView(frame: .zero).then {
        let label = UILabel().then {
            $0.attributedText = NSAttributedString(string: "검색 결과 없음", attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.forContactNotFound
            ])
            
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        $0.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: $0.centerXAnchor),
            label.topAnchor.constraint(equalTo: $0.topAnchor, constant: Constants.ContactView.Padding.notFoundTop)
        ])
        
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    enum ViewState {
        case `default`
        case searchButNotFound
        case searchAndFound
    }
    var viewState = ViewState.default {
        didSet {
            switch viewState {
            case .`default`:
                tableView.isHidden = false
                notFoundView.isHidden = true
                searchedTableView.isHidden = true
            case .searchButNotFound:
                tableView.isHidden = true
                notFoundView.isHidden = false
                searchedTableView.isHidden = true
            case .searchAndFound:
                tableView.isHidden = true
                notFoundView.isHidden = true
                searchedTableView.isHidden = false
            }
        }
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
        
        let _/*trailingBarItem*/ = UIBarButtonItemButton(image: UIImage(systemName: "xmark")!.forNavigationBarXmark, defaultHeight: false).then {
            navigationItem.rightBarButtonItem = $0
            $0.button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        }
        
        navigationItem.backButtonDisplayMode = .minimal
        
        self.textFieldView.do {
            $0.textField.do {
                $0.delegate = self
                $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            }
            
            self.view.addSubview($0)
            self.textFieldViewTrailingAnthor = $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.TextField.Padding.horizontal)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constants.TextField.Padding.top),
                $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.TextField.Padding.horizontal),
                $0.heightAnchor.constraint(equalToConstant: Constants.TextField.ViewHeight.ifself),
                self.textFieldViewTrailingAnthor
            ])
        }
        
        self.cancelButton.do {
            $0.addTarget(self, action: #selector(hideCancelButton), for: .touchUpInside)
            self.view.addSubview($0)
            self.cancelButtonLeadingAnthor = $0.leadingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: Constants.ContactView.Padding.cancelButtonLeadingBeforeShowing).then {
                $0.isActive = true
            }
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor),
                $0.widthAnchor.constraint(equalToConstant: Constants.ContactView.ViewWidth.cancelButton),
                $0.heightAnchor.constraint(equalToConstant: Constants.ContactView.ViewHeight.cancelButton),
            ])
        }
        
        self.tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
            $0.register(ContactTableCell.self, forCellReuseIdentifier: "cell")
            self.view.addSubview($0)
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                $0.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 15),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
        
        self.searchedTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(ContactTableCell.self, forCellReuseIdentifier: "searchedCell")
            self.view.addSubview($0)
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                $0.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 15),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
            
            $0.isHidden = true
        }
        
        self.notFoundView.do {
            self.view.addSubview($0)
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                $0.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 15),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
            
            $0.isHidden = true
        }
    }
    
    func showCancelButton() {
        self.textFieldViewTrailingAnthor.constant = Constants.ContactView.Padding.textFieldViewTrailingAfterShowing
        self.cancelButtonLeadingAnthor.constant = Constants.ContactView.Padding.cancelButtonLeadingAfterShowing
        UIView.animate(withDuration: 0.3, delay: 0, options: []) {
            self.view.layoutIfNeeded()
        }
        self.navigationController!.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func hideCancelButton() {
        self.textFieldViewTrailingAnthor.constant = -Constants.TextField.Padding.horizontal
        self.cancelButtonLeadingAnthor.constant = Constants.ContactView.Padding.cancelButtonLeadingBeforeShowing
        UIView.animate(withDuration: 0.3, delay: 0, options: []) {
            self.view.layoutIfNeeded()
        }
        self.navigationController!.setNavigationBarHidden(false, animated: true)
        self.view.endEditing(true)
        self.textFieldView.textField.text = ""
        self.viewState = .default
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        guard let textField = sender as? UITextField, let text = textField.text else {
            fatalError()
        }
        
        if text.isEmpty {
            self.viewState = .default
        } else {
            textField.attributedText = NSAttributedString(string: text, attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.forTextField
            ])
            
            if FriendManager.shared.friendsWhoseNameContains(string: text).isEmpty {
                self.viewState = .searchButNotFound
            } else {
                self.viewState = .searchAndFound
                self.searchedTableView.reloadData()
            }
        }
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
        if textField.text!.isEmpty {
            self.hideCancelButton()
        }
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
        return tableView == self.tableView ? FriendManager.shared.sortedFriendWithKey.count : 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView == self.tableView ? Constants.ContactView.ViewHeight.header : 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableView == self.tableView ? Constants.ContactView.ViewHeight.footer : .leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView().then { header in
            header.backgroundView = UIView().then {
                $0.backgroundColor = .background
            }
            UILabel().do {
                $0.text = FriendManager.shared.sortedFriendWithKey[section].key
                $0.textColor = .white
                $0.font = .forContactTableSection
                $0.translatesAutoresizingMaskIntoConstraints = false
                header.addSubview($0)
                NSLayoutConstraint.activate([
                    $0.centerYAnchor.constraint(equalTo: header.centerYAnchor),
                    $0.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: Constants.ContactView.Padding.sectionLeading),
                ])
            }
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView().then {
            $0.backgroundView = UIView().then {
                $0.backgroundColor = .background
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.ContactView.ViewHeight.cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.textFieldView.textField.text!.isEmpty {
//            self.hideCancelButton()
        } else {
            
        }
        
        let contactDetailViewController = ContactDetailViewController().then {
            $0.setFriend(with: tableView == self.tableView ? FriendManager.shared.sortedFriendWithKey[indexPath.section].friends[indexPath.row] : FriendManager.shared.friendsWhoseNameContains(string: self.textFieldView.textField.text!)[indexPath.row])
        }
        self.navigationController!.pushViewController(contactDetailViewController, animated: true)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.indicatorStyle = .white
        
        if self.textFieldView.textField.text!.isEmpty {
            self.hideCancelButton()
        } else if viewState != .default {
            self.view.endEditing(true)
        }
    }
}
extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.tableView ? FriendManager.shared.sortedFriendWithKey[section].friends.count : FriendManager.shared.friendsWhoseNameContains(string: self.textFieldView.textField.text!).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            return (tableView.dequeueReusableCell(withIdentifier: "cell") as! ContactTableCell).then {
                $0.setFriend(with: FriendManager.shared.sortedFriendWithKey[indexPath.section].friends[indexPath.row])
            }
        } else {
            return (tableView.dequeueReusableCell(withIdentifier: "searchedCell") as! ContactTableCell).then {
                $0.setFriend(with: FriendManager.shared.friendsWhoseNameContains(string: self.textFieldView.textField.text!)[indexPath.row], searchKeyword: self.textFieldView.textField.text!)
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
    
    func setFriend(with friend: Friend, searchKeyword: String? = nil) {
        self.profileImageView.image = friend.image.forContactCellProfile
        let attributedString = NSMutableAttributedString(string: friend.name, attributes: [
            .paragraphStyle: NSMutableParagraphStyle().then {
                $0.alignment = .left
                $0.lineBreakMode = .byTruncatingTail
            }]
        )
        self.backgroundColor = .background
        self.selectedBackgroundView = UIView().then {
            $0.backgroundColor = .selectedGray
        }
        
        if searchKeyword != nil {
            var range = NSRange(location: 0, length: friend.name.count)
            
            while range.location != NSNotFound {
                range = (friend.name as NSString).range(of: searchKeyword!, options: .caseInsensitive, range: range)
                attributedString.addAttribute(.foregroundColor, value: UIColor.green, range: range)
                
                if range.location != NSNotFound {
                    range = NSRange(location: range.location + range.length, length: friend.name.count - (range.location + range.length))
                }
            }
        }
        
        self.profileNameLabel.attributedText = attributedString
    }
}
