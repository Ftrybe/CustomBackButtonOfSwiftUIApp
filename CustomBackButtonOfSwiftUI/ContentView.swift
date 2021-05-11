//
//  ContentView.swift
//  CustomBackButtonOfSwiftUI
//
//  Created by ftrybe on 2021/5/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MainView()
            
            /// Ipad下将显示在右边
            SecondView(index: 0)
        }
    }
}

struct MainView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Main")
                    .font(.largeTitle)
                Spacer()
            }.padding()
            
            List {
                ForEach(1...5,id: \.self) { index in
                    // ios 14.5 bug
                    //            NavigationLink( destination: SecondView(index: index)){
                    //                Text("\(index)")
                    //            }
                    Button(action: {
                        NavigationManager.shared.forward(){ SecondView(index: index)}
                    }, label: {
                        HStack {
                            Text("main view index \(index)")
                            Spacer()
                        }
                    })
                }
                .id(UUID())
                Button(action: {
                    NavigationManager.shared.forward(content: { ThirdView()}, backView: { SecondView(index: 4) })
                }, label: {
                    HStack {
                        Text("go back view index of 4 ")
                        Spacer()
                    }
                })
            }
            
            NavigationLinkGroup()
        }
        
        .navigationBarHidden(true)
    }
}


struct NavigationLinkGroup: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        Group {
            NavigationLink(destination: navigationManager.content, isActive: $navigationManager.showingMain) {EmptyView()}
            
            NavigationLink(destination: navigationManager.content, isActive: $navigationManager.showingSub) {EmptyView()}
        }
    }
}

struct SecondView: View {
    @EnvironmentObject private var orientationInfo: OrientationInfo
    @Environment(\.presentationMode) private var presentationMode
    
    var index: Int = 0
    
    var body: some View {
        
        ZStack {
            VStack {
                NavigationLink("index \(index)", destination: ThirdView())
            }
            
            ToolBar()
        }
        .iPhone {
            $0.navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.all)
        
    }
    
    func ToolBar() -> some View {
        VStack {
            HStack {}.iPhone { _ in
                HStack {
                    // 后退
                    BackButtonIcon()
                    
                    Spacer()
                    
                }
                
            }.iPad { _ in
                HStack {
                    
                    // hidden back button
                    if orientationInfo.orientation == .portrait {
                        // 后退
                        BackButtonIcon()
                    }
                    Spacer()
                }
                .padding(.all, 8)
            }
            
            Spacer()
        }
        .padding(.top, UIApplication.safeAreaInsetsTop == 0 ? 15: UIApplication.safeAreaInsetsTop)
        .padding(.horizontal, 15)
    }
    
    func BackButtonIcon() -> some View {
        Image("icon.arrow.left")
            .renderingMode(.template)
            .resizable()
            .frame(width: 24, height: 24)
            .padding(.all, 6)
            .background(Color.black.opacity(0.2).clipShape(Circle()).shadow(radius: 4))
            .foregroundColor(Color.white)
            .cornerRadius(30)
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
    }
}


struct ThirdView: View {
    @EnvironmentObject private var orientationInfo: OrientationInfo
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                
                Image("icon.close")
                    .foregroundColor(.black)
                    .frame(width: 36, height: 36)
                    //                    .iPad{ $0.hidden()}
                    .onTapGesture(perform: {
                        dismiss()
                    })
            }
            Spacer()
            
            Text("presentationMode.wrappedValue.dismiss()")
            
            Text("toggle sidebar")
                .onTapGesture {
                    UISplitViewController.isHide.toggle()
                }.iPhone{
                    $0.hidden()
                }.iPad {
                    $0.opacity(orientationInfo.orientation == .landscape ? 0 : 1)
                }
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func dismiss() {
        guard NavigationManager.shared.stack.isEmpty() else{
            NavigationManager.shared.back()
            return
        }
        presentationMode.wrappedValue.dismiss()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
