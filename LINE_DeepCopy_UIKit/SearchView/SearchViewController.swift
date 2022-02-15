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
    }
    
    @objc func popToRootView() {
        self.navigationController!.popToRootViewController(animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
        
        for subView in self.searchBar.subviews {
            for subsubView in subView.subviews {
                if let textField = subsubView as? UITextField {
                    var bounds = textField.bounds
                    bounds.size.height = 200
                    textField.bounds = bounds
                }
            }
        }
        
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
    }
}

extension UIView {
    func printSubview(depth: Int) {
        if depth == 1 {
            print("\(depth)\t\(type(of: self))\t\t\(self)")
            self.frame = CGRect(x: 0, y: 0, width: 0, height: 100)
        }
        
        print("\(depth)\t\(type(of: self))\t\t\(self)")
        self.subviews.forEach { $0.printSubview(depth: depth + 1) }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
}
