//
//  SplashView.swift
//  DreamerlyTest
//
//  Created by Long Quách on 09/09/2024.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @EnvironmentObject var authenViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            if isActive {
                switch authenViewModel.state {
                case .signedOut:
                    LoginView(loginViewModel: LoginViewModel(authViewModel: authenViewModel))
                case .signedIn:
                    HomeView()
                }
            } else {
                VStack {
                    Assets.icLogoTinai.swiftUIImage
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                    Text(Strings.streamerly)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Assets.primaryColor.swiftUIColor)
                }
                .transition(.scale)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
