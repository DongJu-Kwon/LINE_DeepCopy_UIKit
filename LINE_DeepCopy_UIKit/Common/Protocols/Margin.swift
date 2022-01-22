//
//  Margin.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/19.
//

import UIKit

protocol Margin {
    func setWidth(_ size: CGFloat)
    func setHeight(_ size: CGFloat)
    func setCenter(target: UIView)
    func setTopMargin(target: UIView, _ size: CGFloat)
    func setBottomMargin(target: UIView, _ size: CGFloat)
    func setHorizontalMargin(target: UIView, _ size: CGFloat)
}

extension Margin where Self: UIView {
    func setWidth(_ size: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: size).isActive = true
    }
    func setFullWidth(target: UIView) {
        self.leadingAnchor.constraint(equalTo: target.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: target.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    func setFullHeight(target: UIView) {
        self.topAnchor.constraint(equalTo: target.safeAreaLayoutGuide.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: target.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    func setFullLayout(target: UIView) {
        self.setFullWidth(target: target)
        self.setFullHeight(target: target)
    }
    
    func setHeight(_ size: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    func setCenter(target: UIView) {
        self.centerXAnchor.constraint(equalTo: target.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: target.centerYAnchor).isActive = true
    }
    
    func setTopMargin(target: UIView, _ size: CGFloat) {
        self.topAnchor.constraint(equalTo: target.bottomAnchor, constant: size).isActive = true
    }
    
    func setBottomMargin(target: UIView, _ size: CGFloat) {
        self.bottomAnchor.constraint(equalTo: target.topAnchor, constant: -size).isActive = true
    }
    
    func setHorizontalMargin(target: UIView, _ size: CGFloat) {
//        self.leftAnchor.constraint(equalTo: target.leftAnchor, constant: size).isActive = true
//        self.rightAnchor.constraint(equalTo: target.rightAnchor, constant: -size).isActive = true
        self.leadingAnchor.constraint(equalTo: target.leadingAnchor, constant: size).isActive = true
        self.trailingAnchor.constraint(equalTo: target.trailingAnchor, constant: -size).isActive = true
    }
}

extension UITableView: Margin {}
