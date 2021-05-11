//
//  CustomBackButtonOfSwiftUIApp.swift
//  CustomBackButtonOfSwiftUI
//
//  Created by ftrybe on 2021/5/10.
//

import SwiftUI

@main
struct CustomBackButtonOfSwiftUIApp: App {
    let orientationInfo = OrientationInfo()
    let navigationManager = NavigationManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(orientationInfo)
                .environmentObject(navigationManager)
        }.commands {
            // 切换命令
            SidebarCommands()
        }
    }
}
