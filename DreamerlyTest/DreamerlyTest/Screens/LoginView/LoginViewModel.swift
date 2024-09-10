//
//  LoginViewModel.swift
//  DreamerlyTest
//
//  Created by Long Quách on 10/09/2024.
//

import Foundation
import SwiftUI

final class LoginViewModel: BaseViewModel{
    @Published var isLogined = false
    @Published var authViewModel: AuthenticationViewModel
    
    init(authViewModel: AuthenticationViewModel) {
        self.authViewModel = authViewModel
    }
    
    func isUserEnableLocalAuthen() -> Bool {
        return authViewModel.getUserEnableLocalAuthen()
    }
    
    func loginWithFaceID() {
        authViewModel.localAuthenticate()
    }
    
}
