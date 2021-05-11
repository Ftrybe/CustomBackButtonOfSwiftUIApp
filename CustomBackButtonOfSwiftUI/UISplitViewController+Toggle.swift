//
//  UISplitViewController+Ipad.swift
//  ITime-ios
//
//  Created by ftrybe on 2021/5/10.
//


import SwiftUI

extension UISplitViewController {
    /// 用于控制侧边栏显示
    public static var isHide = false {
        didSet {
            let controller = UIApplication.shared.windows.first { $0.isKeyWindow }!.rootViewController
            guard let split = controller?.children[0] as? UISplitViewController else {
                print("not a split view")
                return
            }
            if isHide {
                split.dismiss(animated: true) {
                    isHide = false
                }
                split.show(.primary)
               
            } else {
                split.hide(.primary)
            }
        }
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        /// 设置侧边栏宽度
        maximumPrimaryColumnWidth = 400
        preferredPrimaryColumnWidthFraction = 400
    }
}
