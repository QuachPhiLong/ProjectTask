//
//  LoginView.swift
//  DreamerlyTest
//
//  Created by Long Quách on 10/09/2024.
//
import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel: LoginViewModel
    
    var body: some View {
        Button(action: {
            loginViewModel.loginWithFaceID()
        }){
            Image(systemName: "faceid").resizable().frame(width: 100, height: 100)
        }.onAppear{
            loginViewModel.loginWithFaceID()
        }
    }
}
