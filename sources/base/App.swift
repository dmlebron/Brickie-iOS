//
//  Brickie.swift
//  Brickie
//
//  Created by Work on 03/11/2020.
//  Copyright © 2020 Homework. All rights reserved.
//

import SwiftUI
import Combine
let kCollection = UserCollection()
var kConfig = Configuration()

@main
struct TheApp : App {
    
    var networkCancellable :AnyCancellable? = {
        kConfig.$connection
            .debounce(for: .seconds(2), scheduler: DispatchQueue.main)
            .filter{ !$0.cantUpdateDB }
            .sink { _ in
                kCollection.requestForSync = true
                
            }
    }()
    var body : some Scene {
        WindowGroup{
            AppRootView().environmentObject(kCollection).environmentObject(kConfig)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    kCollection.backup()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
                    kCollection.backup()
                }
                .onAppear {
                    tweakThatShit()
                }
        }
    }
    
    
    func tweakThatShit(){
        UITableView.appearance().tableFooterView = UIView()
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.font:UIFont(name: "LEGothicType", size: 34)!,
            
            
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font:UIFont(name: "LEGothicType", size: 17)!,
        ]
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "LEGothicType", size: 17)!], for: .normal)
        
    }
}

