//
//  SearchViewController.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/02/13.
//

import UIKit
import Then

class SearchViewController: UIViewController {
    let searchBar = UISearchBar().then {
        $0.setImage(UIImage(systemName: "magnifyingglass")!.forTextfieldSearch, for: .search, state: .normal)
        $0.tintColor = .white
        /*
         * UISearchBarTextField: searchBar.subviews[0].subviews[1].subviews[0]
         */
    }
    
    let recentKeywordView = UIView().then { view in
        view.translatesAutoresizingMaskIntoConstraints = false
        
        UILabel().do {
            $0.text = "최근 검색어"
            $0.textColor = .white
            $0.textAlignment = .left
            $0.font = .forSearchViewHistoryTitle
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
            
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.SearchView.HistoryView.Padding.top),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.SearchView.HistoryView.Padding.leading),
            ])
        }
    }
    
    let historyInformLabel = UILabel().then {
        $0.attributedText = NSAttributedString(string: "검색 내역이 없습니다.", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.forSearchViewNoneHistory
        ])
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let autoSaveButton = AutoSaveButton()
    let removeAllHistoryButton = UIButton().then {
        let attributedString = NSMutableAttributedString(string: "  |  전체 삭제", attributes: [
            .font: UIFont.forSearchViewAutoSaveButton,
            .foregroundColor: UIColor.gray,
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor.borderGray, range: NSRange(location: 0, length: 4))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 11), range: NSRange(location: 0, length: 4))
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    enum ViewState {
        case autoSaveDisabled
        case noneRecentKeyword
        case someRecentKeyword
        case searchKeyword
    }
    var viewState = ViewState.noneRecentKeyword {
        didSet {
            switch viewState {
            case .autoSaveDisabled:
                self.historyInformLabel.isHidden = false
                self.historyInformLabel.text = "검색어 저장 기능이 꺼져 있습니다."
                self.removeAllHistoryButton.isHidden = true
            case .noneRecentKeyword:
                self.historyInformLabel.isHidden = false
                self.historyInformLabel.text = "검색 내역이 없습니다."
                self.removeAllHistoryButton.isHidden = true
            case .someRecentKeyword:
                self.historyInformLabel.isHidden = true
                self.removeAllHistoryButton.isHidden = false
                break
            case .searchKeyword:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .background
        
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItemButton(image: UIImage(systemName: "chevron.backward")!.forNavigationBarXmark, defaultHeight: false).then {
            $0.button.addTarget(self, action: #selector(popToRootView), for: .touchUpInside)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItemButton(image: UIImage(systemName: "xmark")!.forNavigationBarXmark, defaultHeight: false).then {
            $0.button.addTarget(self, action: #selector(popToRootView), for: .touchUpInside)
        }
        
        searchBar.placeholder = "검색"
        searchBar.subviews[0].subviews[1].subviews[0].do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: $0.superview!.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: $0.superview!.centerYAnchor),
                $0.widthAnchor.constraint(equalTo: $0.superview!.widthAnchor, constant: Constants.NavigationBar.Padding.searchBarHorizontal),
                $0.heightAnchor.constraint(equalToConstant: Constants.NavigationBar.ViewHeight.searchBar)
            ])
        }
        
        recentKeywordView.do {
            $0.addBorder(y: Constants.SearchView.HistoryView.ViewHeight.noneRecentKeyword, width: self.view.frame.width)
            self.view.addSubview($0)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constants.SearchView.HistoryView.Padding.top),
                $0.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                $0.heightAnchor.constraint(equalToConstant: Constants.SearchView.HistoryView.ViewHeight.noneRecentKeyword)
            ])
        }
        
        self.historyInformLabel.do {
            recentKeywordView.addSubview($0)
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: recentKeywordView.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: recentKeywordView.centerYAnchor, constant: Constants.SearchView.HistoryView.Padding.noneHistoryInformCenterY)
            ])
        }
        
        self.autoSaveButton.do {
            self.view.addSubview($0)
            
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: recentKeywordView.bottomAnchor, constant: Constants.SearchView.HistoryView.Padding.autoSaveButtonTop),
                $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.SearchView.HistoryView.Padding.leading),
                $0.widthAnchor.constraint(equalToConstant: $0.intrinsicContentSize.width),
                $0.heightAnchor.constraint(equalToConstant: Constants.SearchView.HistoryView.ViewHeight.autoSaveButton)
            ])
            $0.addTarget(self, action: #selector(toggleAutoSave), for: .touchUpInside)
        }
        self.removeAllHistoryButton.do {
            self.view.addSubview($0)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: recentKeywordView.bottomAnchor, constant: Constants.SearchView.HistoryView.Padding.autoSaveButtonTop),
                $0.leadingAnchor.constraint(equalTo: self.autoSaveButton.trailingAnchor),
                $0.widthAnchor.constraint(equalToConstant: $0.intrinsicContentSize.width),
                $0.heightAnchor.constraint(equalToConstant: Constants.SearchView.HistoryView.ViewHeight.autoSaveButton)
            ])
            $0.addTarget(self, action: #selector(removeAllHistory), for: .touchUpInside)
            
            self.removeAllHistoryButton.isHidden = false
        }
        
        self.viewState = .autoSaveDisabled
    }
    
    
    
    @objc func popToRootView() {
        self.navigationController!.popToRootViewController(animated: false)
    }
    
    @objc func toggleAutoSave() {
        present(UIAlertController(title: "", message: "검색어 저장 기능을 \(self.viewState == .autoSaveDisabled ? "켜시" : "끄시")겠습니까?", preferredStyle: .alert).then {
            $0.addAction(.cancel)
            $0.addAction(.confirm() { _ in
                self.autoSaveButton.toggle()
                switch self.viewState {
                case .autoSaveDisabled:
                    self.viewState = .noneRecentKeyword
                case .noneRecentKeyword, .someRecentKeyword:
                    self.viewState = .autoSaveDisabled
                default:
                    fatalError()
                }
            })
        }, animated: true)
    }
    
    @objc func removeAllHistory() {
        present(UIAlertController(title: "", message: "검색어를 모두 삭제하시겠습니까?", preferredStyle: .alert).then {
            $0.addAction(.cancel)
            $0.addAction(.confirm() { _ in
                print("delete")
            })
        }, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

class AutoSaveButton: UIButton {
    private var doesAutoSaving = false
    
    init() {
        super.init(frame: .zero)
        
        self.setAttributedTitle(NSAttributedString(string: "자동 저장 \(self.doesAutoSaving ? "끄기" : "켜기")", attributes: [
            .font: UIFont.forSearchViewAutoSaveButton,
            .foregroundColor: UIColor.gray,
        ]), for: .normal)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggle() {
        self.doesAutoSaving.toggle()
        self.blink()
    }
    
    func blink() {
        UIView.animate(withDuration: 0.2, delay: .zero, options: [.curveEaseInOut], animations: {
            self.alpha = 0
        }, completion: { _ in
            self.setAttributedTitle(NSAttributedString(string: "자동 저장 \(self.doesAutoSaving ? "끄기" : "켜기")", attributes: [
                .font: UIFont.forSearchViewAutoSaveButton,
                .foregroundColor: UIColor.gray,
            ]), for: .normal)
            
            UIView.animate(withDuration: 0.2, delay: .zero, options: [.curveEaseInOut], animations: {
                self.alpha = 1
            })
        })
    }
}
