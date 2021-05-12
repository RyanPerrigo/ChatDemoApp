//
//  SecondViewControllerModel.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/4/21.
//

import Foundation

struct ChatRoomVCState {
	
	private var textFieldState: String = ""
	private var viewModelDisplayState: [Person] = []
	private var personState: ChoosePerson = .personOne
	private var mainUserChatMessageState: [String] = []
	private var isSelf: Bool = true
	

	
	mutating func setTextFieldState(text: String) {
		self.textFieldState = text
	}
	
	mutating func addViewModelToDisplayState(person: Person) {
		viewModelDisplayState.append(person)
	}
	mutating func setPersonState(choosePerson: ChoosePerson) {
		switch personState {
		case .personOne:
			personState = .PersonTWo
		case .PersonTWo:
			personState = .personOne
		}
	}
	mutating func addMessageToMainUserMessageState(message: String) {
		mainUserChatMessageState.append(message)
	}
	mutating func changeIsSelfState() {
		switch isSelf {
		case true:
			isSelf = false
		default:
			isSelf = true
		}
	}
	func getIsSelfState() -> Bool {
		return isSelf
	}
	func getMainUserMessages() -> [String] {
		return mainUserChatMessageState
	}
	func getTextFieldState() -> String {
		return textFieldState
	}
	func getViewModelDisplayState() -> [Person] {
		return viewModelDisplayState
	}
	func getPersonState() -> ChoosePerson {
		return personState
	}
}


class ChatRoomVM {
	
	private let apiHandler = APIManager()
	var state: ChatRoomVCState = ChatRoomVCState()
	
	var onTextFieldChanged: ((String)->Void)?
	var reloadView: (()->Void)?
	var resetTextField: (()->Void)?
	
	func onSendButtonClicked() {
		
		let person = Person(user: User(isSelf: state.getIsSelfState(), uuid: String(describing: UUID()), messages: []), choosePerson: state.getPersonState(), message: state.getTextFieldState())
		
		
		switch state.getPersonState() {
		case .personOne:
			
			state.addViewModelToDisplayState(person: person)
		case .PersonTWo:
			state.addViewModelToDisplayState(person: person)
		}
		resetTextField?()
		reloadView?()
		
	
	}
	func onSwapPressed() {
		let currentState = state.getPersonState()
		
		
		switch currentState {
		case .personOne:
			print("Changing from \(currentState) to Person Two")
			state.setPersonState(choosePerson: .PersonTWo)
		case .PersonTWo:
			print("Changing from \(currentState) to Person One")
			state.setPersonState(choosePerson: .personOne)
			
		}
		
	}
	func createNewChatMessageFromPerson (chatMessage: String) -> ChatMessage{
		let timeStamp = NSTimeIntervalSince1970
		let message = createNewMessagePayload(messagePayload: MessagePayload(messageText: chatMessage), imagePayload: nil)
		var userMessages: [Message] = []
		let user = User(isSelf: state.getIsSelfState(), uuid: String(describing: UUID()), messages: userMessages)
		userMessages.append(message)
		let chatMessage = ChatMessage(user: user, messageType: MessageType.text, timeStamp: timeStamp, uuid: String(describing: UUID()), messagePayload: message)
	
		return chatMessage
	}
	
	func attachMessagePayloadToPerson() -> Person {
		
		var messages: [Message] = []
		let messagePayload = createNewMessagePayload(messagePayload: MessagePayload(messageText: state.getTextFieldState()), imagePayload: nil)
		messages.append(messagePayload)
		let user = User(isSelf: state.getIsSelfState(), uuid: String(describing: UUID()), messages: messages)
		
		let person = Person(user: user, choosePerson: state.getPersonState(), message: state.getTextFieldState())
		return person
	}
	func createNewMessagePayload(messagePayload: MessagePayload?, imagePayload: ImagePayload?) -> Message{
		let timeStamp = NSTimeIntervalSince1970
		let newMessage = Message(
			timeStamp: timeStamp,
			uuid: String(describing: UUID()),
			messagePayload: messagePayload,
			imagePayload: imagePayload
		)
		return newMessage
	}
	
	func getSafePayload(messagePayload: MessagePayload?) -> MessagePayload {
		guard let safePayload = messagePayload else {
			return MessagePayload(messageText: "COULDNT GET PAYLOAD PROPERLY")
		}
		return safePayload
	}
}
