//
//  NavigationManager.swift
//  ITime-ios
//
//  Created by ftrybe on 2021/5/5.
//

import SwiftUI
import Foundation

class NavigationManager: ObservableObject {
    
    static let shared: NavigationManager = {
        return NavigationManager()
    }()
    
    @Published var showingMain: Bool
    @Published var showingSub: Bool
    @Published var content: AnyView
    @Published var stack: NavigationStack
    
    init() {
        showingMain = false
        showingSub = false
        content = AnyView(EmptyView())
        stack = NavigationStack()
    }
    
    func forward<T:View,Z:View>(content: @escaping () -> T, backView: @escaping () -> Z ){
        showView()
        self.content = AnyView(content())
        pushView(content: backView)
        objectWillChange.send()
    }
    
    func forward<T:View>(content: @escaping () -> T ) {
        showView()
        self.content = AnyView(content())
        stack.clear()
        objectWillChange.send()
    }
    
    
    func back() {
        if stack.isEmpty(){
            self.content = AnyView(SecondView(index: 0))
        } else {
            self.content = self.stack.pop()
        }
        
        showView()
        objectWillChange.send()
    }
    
    func pushView<T>(content: @escaping () -> T) where T: View{
        if deviceType == .ipad {
            self.stack.push(AnyView(content()))
        }
    }
    
    private func showView() {
        if !showingMain,!showingSub {
            showingMain = true
        } else if showingMain,!showingSub {
            showingSub = true
        } else if !showingMain,showingSub {
            showingMain = true
        }
    }
}

class NavigationStack: Stackable {
    //给关联类型设置真实类型
    typealias Element = AnyView
    
    var elements = [AnyView]()
    
    func size() -> Int { elements.count }
    
    func push(_ element: AnyView) {
        elements.append(element)
        if size() > 5 {
            elements.removeFirst()
        }
    }
    
    func pop() -> AnyView { elements.removeLast()}
    
    func top() -> AnyView { elements.last! }
    
    func isEmpty() -> Bool { elements.isEmpty }
    
    func clear() {
        guard isEmpty() else {
            elements.removeAll()
            return
        }
    }
}

protocol Stackable {
    associatedtype Element //关联类型（可以理解泛型）
    mutating func push(_ element: Element) //入栈
    mutating func pop() -> Element //出栈
    func size() -> Int //元素的数量
    func top() -> Element //获取栈顶元素
    func isEmpty() -> Bool //是否为空
    func clear() -> Void // 清空
}

