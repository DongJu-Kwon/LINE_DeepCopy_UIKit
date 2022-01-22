//
//  ContactViewController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/19.
//

import UIKit

class ContactViewController: UIViewController {
    
    let textFieldView = CustomTextFieldView(forContactView: true)
    var tableView: UITableView!
    
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
//        navigationBar.tintColor = .white
//        navigationBar.barTintColor = .gray
//        navigationBar.backgroundColor = .green
//        print(self.navigationBar.frame.height)
        
        let trailingBarItem = UIBarButtonItemButton(image: UIImage(systemName: "xmark")!)
        navigationItem.rightBarButtonItem = trailingBarItem
        
        trailingBarItem.button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        textFieldView.textField.delegate = self
        view.addSubview(textFieldView)
        textFieldView.setHorizontalMargin(target: view, Constants.TextField.Margin.horizontal)
        textFieldView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        textFieldView.setHeight(Constants.TextField.ViewHeight.ifself)
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(ContactTableCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.sectionFooterHeight = 0
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.setFullLayout(target: view)
        tableView.setFullWidth(target: view)
        tableView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
//        let scrollView = CustomScrollView()
//        self.view.addSubview(scrollView)
//        scrollView.setFullLayout(target: view)
//        scrollView.backgroundColor = .blue
//
//        let contentView = CustomView()
//        contentView.backgroundColor = .purple
//        scrollView.addSubview(contentView)
//
//        NSLayoutConstraint.activate([
//            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
//            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
//        ])
//
//        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
//        contentViewHeight.priority = .defaultLow
//        contentViewHeight.isActive = true
//
//        let contactFriendView = ContactFriendView(image: UIImage(systemName: "flame.circle")!, name: "Baek Gayoung")
//        contentView.addSubview(contactFriendView)
//        contactFriendView.setFullWidth(target: contentView)
//        contactFriendView.setHeight(Constants.ContactCellHeight)
//        contactFriendView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
//        contactFriendView.backgroundColor = .brown
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
        return 10
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "asdf"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //do Navigation!
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .background
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.ContactCell.ViewHeight.section
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.ContactCell.ViewHeight.cell
    }
}
extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendList.friendArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContactTableCell
        
        cell.profileImageView.image = FriendList.friendArray[indexPath.row].image.forContactProfileImage
        cell.profileNameLabel.text = FriendList.friendArray[indexPath.row].name
        
        cell.backgroundColor = .background//UIColor(red: .random(in: 0.1...0.3), green: .random(in: 0.1...0.3), blue: .random(in: 0.1...0.3), alpha: 1)
        
        return cell
    }
}

class ContactTableCell: UITableViewCell {
    
    var profileImageView: ContactProfileImageView!
    var profileNameLabel: ContactProfileNameLabel!
    let callImageView = UIImageView(image: UIImage(systemName: "phone")!.forContactCallImage)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        profileImageView = ContactProfileImageView()
        profileNameLabel = ContactProfileNameLabel()
        callImageView.tintColor = .gray
        callImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(profileNameLabel)
        contentView.addSubview(callImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            profileNameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            callImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            callImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -18),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ContactProfileImageView: UIImageView {
    let lineImageView = UIImageView(image: UIImage(systemName: "message.fill")!.forContactLineImage)
    
    init() {
        super.init(frame: .zero)
        
        lineImageView.tintColor = .green
        
        addSubview(lineImageView)
        lineImageView.translatesAutoresizingMaskIntoConstraints = false
        lineImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContactProfileImageView: Margin {}

class ContactProfileNameLabel: UILabel {
    init() {
        super.init(frame: .zero)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        self.attributedText = NSAttributedString(string: "", attributes: [.paragraphStyle: paragraphStyle])
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.numberOfLines = 1
        self.font = .forContactName
        self.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContactProfileNameLabel: Margin {}
