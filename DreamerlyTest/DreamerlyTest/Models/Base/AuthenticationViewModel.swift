//
//  LoginView.swift
//  DreamerlyTest
//
//  Created by Long Quách on 10/09/2024.
//

import LocalAuthentication

class AuthenticationViewModel: ObservableObject {
	
	@Storage(key: "userEnableLocalAuthentication", defaultValue: false)
	static var userEnableLocalAuthentication: Bool
	
	enum SignInState {
		case signedIn
		case signedOut
	}
	
	@Published var state: SignInState = .signedOut
	@Published var isLoading = false
	
	func deviceIsSupportBiometricAuthen() -> Bool {
		let context = LAContext()
		var error: NSError?
		
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			return true
		}
		return false
	}
	
	func localAuthenticate() {
		let context = LAContext()
		var error: NSError?
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "We need to unlock your data."
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
				if success {
					DispatchQueue.main.async(execute: {
						self.state = .signedIn
						self.setUserEnableLocalAuthen(enable: true)
					})
				}
			}
		} else {
			// no biometrics
		}
		
	}
	
	func setUserEnableLocalAuthen(enable: Bool) {
		Self.userEnableLocalAuthentication = enable
	}
	
	func getUserEnableLocalAuthen() -> Bool {
		return Self.userEnableLocalAuthentication
	}
}
