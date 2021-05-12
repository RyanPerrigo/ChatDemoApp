//
//  CreateNewUserVM.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/12/21.
//

import Foundation


struct CreateNewUserVMState {
	private var passwordState: String = ""
	private var emailState: String = ""
	
	
	mutating func setPasswordState(text: String) {
		passwordState = text
	}
	mutating func setEmailState(text: String) {
		emailState = text
	}
	func getPasswordState() -> String {
		return passwordState
	}
	func getEmailState() -> String {
		return emailState
	}
}

class CreateNewUserVCM {
	
	
	var state = CreateNewUserVMState()
	
	
	
	
	
}
