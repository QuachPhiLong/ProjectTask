//
//  DreamerlyTestApp.swift
//  DreamerlyTest
//
//  Created by Long Quách on 09/09/2024.
//

import SwiftUI
import CoreStore

@main
struct DreamerlyTestApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var global = GlobalModel()
    @StateObject var authenViewModel = AuthenticationViewModel()
    init() {
        do {
            let dataStack = DataStack(xcodeModelName: "database")
            try dataStack.addStorageAndWait()
            CoreStoreDefaults.dataStack = dataStack
        }
        catch {
            fatalError("CoreStore db Error")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(global)
                .environmentObject(authenViewModel)
        }.onChange(of: scenePhase) { oldValue, newValue in
            switch newValue {
            case .background:
                print("App State : Background")
                break
            case .inactive:
                print("App State : Inactive")
                break
            case .active:
                print("App State : Active")
            @unknown default:
                print("App State : Unknown")
            }
        }
    }
    
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]
                     , fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
    
}
