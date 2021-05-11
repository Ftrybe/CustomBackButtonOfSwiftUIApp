//
//  UINavigationController+Tint.swift
//  CustomBackButtonOfSwiftUI
//
//  Created by ftrybe on 2021/5/10.
//


import Foundation
import SwiftUI

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        /// 将导航栏按钮设置为透明
        navigationBar.tintColor = UIColor.clear
        navigationItem.backButtonDisplayMode = .minimal
        navigationBar.backIndicatorImage = nil
    }
}
