//
//  SecondViewControllerModel.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/4/21.
//

import Foundation

struct SecondVCState {
	
	var textFieldState: String = ""
	var viewModelDisplayState: [Person] = []
	var personState: ChoosePerson = .personOne

	
	mutating func setTextFieldState(text: String) {
		self.textFieldState = text
	}
	
	mutating func addViewModelToDisplayState(person: Person) {
		viewModelDisplayState.append(person)
	}
	
	func getTextFieldState() -> String {
		return textFieldState
	}
	func getViewModelDisplayState() -> [Person] {
		return viewModelDisplayState
	}
}


class SecondViewControllerModel {
	
	
	var state: SecondVCState = SecondVCState()
	
	var onTextFieldChanged: ((String)->Void)?
	var reloadView: (()->Void)?
	var resetTextField: (()->Void)?
	
	func onSendButtonClicked() {
		let personOne = Person(message: state.getTextFieldState(), isSelf: .personOne)
		let personTwo = Person(message: state.getTextFieldState(), isSelf: .PersonTWo)
		
		switch state.personState {
		case .personOne:
			state.addViewModelToDisplayState(person: personOne)
		case .PersonTWo:
			state.addViewModelToDisplayState(person: personTwo)
		}
		resetTextField?()
		reloadView?()
	}
	func onSwapPressed() {
		let currentState = state.personState
		
		
		switch currentState {
		case .personOne:
			print("Changing from \(currentState) to Person Two")
			state.personState = .PersonTWo
		case .PersonTWo:
			print("Changing from \(currentState) to Person One")
			state.personState = .personOne
			
		}
	}
	
	
}
