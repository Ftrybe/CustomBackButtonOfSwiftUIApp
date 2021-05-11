//
//  UIApplication+SafeAreaInsets.swift
//  CustomBackButtonOfSwiftUI
//
//  Created by ftrybe on 2021/5/10.
//

import SwiftUI

extension UIApplication{
   static let safeAreaInsetsTop = UIApplication.shared.windows.first?.safeAreaInsets.top
    
   static let safeAreaInsetsBottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom
}
