//
//  ContentView.swift
//  DreamerlyTest
//
//  Created by Long Quách on 09/09/2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var global: GlobalModel // Global model
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // App delegate
    @EnvironmentObject var authenViewModel: AuthenticationViewModel
    
    var body: some View {
        SplashView().environmentObject(authenViewModel)
    }
}

#Preview {
    ContentView()
}
