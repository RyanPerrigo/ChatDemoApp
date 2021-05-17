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
	private var payloadType: PayloadType = .message
	var updateDisplayCallBack: (()->Void)?

	
	mutating func setTextFieldState(text: String) {
		self.textFieldState = text
	}
	
	mutating func addViewModelToDisplayState(person: Person) {
		viewModelDisplayState.append(person)
		updateDisplayCallBack!()
	}
	mutating func setViewModelDisplayStateArray(arrayOfPerson: [Person]) {
		viewModelDisplayState = arrayOfPerson
		updateDisplayCallBack!()
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
		switch personState {
		case .personOne:
			isSelf = true
		case .PersonTWo:
			isSelf = false
		}
	}
	mutating func changePayloadType() {
		switch payloadType {
		case .image:
			payloadType = .message
		case .message:
			payloadType = .image
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
	func getPayloadTypeState() -> PayloadType {
		return payloadType
	}
}


class ChatRoomVM {
	
	private let apiHandler = APIManager()
	var state: ChatRoomVCState = ChatRoomVCState()
	
	var onTextFieldChanged: ((String)->Void)?
	var reloadView: (()->Void)?
	var resetTextField: (()->Void)?
	
	func onSendButtonClicked() {
		
		postNewChatMessage()

//				let person: [Person] = safeData.messages.compactMap { chatMessage in
//					let person = Person(
////						user: User(
////							isSelf: chatMessage.user.isSelf,
////							uuid: chatMessage.user.uuid,
////							messages: chatMessage.user.messages
////						),
//						choosePerson: getIsSelf(isSelf: chatMessage.user.isSelf),
//						message: chatMessage.messagePayload.messagePayload!.messageText
//					)
//					return person
//				}
//				person.forEach { person in
//					state.addViewModelToDisplayState(person: person)
//					self.reloadView!()
//				}
//			}
//		}

		//let person = Person(user: User(isSelf: state.getIsSelfState(), uuid: String(describing: UUID()), messages: []), choosePerson: state.getPersonState(), message: state.getTextFieldState())
		
		
//		switch state.getPersonState() {
//		case .personOne:
//
//			state.addViewModelToDisplayState(person: person)
//		case .PersonTWo:
//			state.addViewModelToDisplayState(person: person)
//		}
		
		
		
	
	}
	
	
	// This function is used to determine wether or not the sender is the device user or any other user
	
	
//	func getChoosePersonFromResponse(isSelf: Bool) -> ChoosePerson{
//		if isSelf {
//			return .personOne
//		} else {
//			return .PersonTWo
//		}
//	}
	
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
		state.changeIsSelfState()
	}
	func createNewChatMessageWithPayloadType (messageTypePayload: MessageTypePayload?, imageTypePayload: ImageTypePayload?, messsageType: String) -> ChatMessage{
		let timeStamp = NSTimeIntervalSince1970
		let payload = MessagePayload(
			timeStamp: timeStamp,
			messageUUID: String(describing: UUID()),
			messageTypePayload: messageTypePayload,
			imageTypePayload: imageTypePayload
		)
		let user = User(
					  isSelf: state.getIsSelfState(),
					  userUUID: String(describing: UUID()),
					  userMessages: [payload]
		)
		let chatMessage = ChatMessage(
			user: user,
			messageType: MessageType.text,
			timeStamp: timeStamp,
			chatMessageUUID: String(describing: UUID()),
			chatMessagePayload: MessagePayload(
				timeStamp: timeStamp,
				messageUUID: String(describing: UUID()),
				messageTypePayload: messageTypePayload,
				imageTypePayload: imageTypePayload)
		)
		
	
		return chatMessage
	}
	
	func getUser(messagePayload: MessageTypePayload?, imagePayload: ImageTypePayload?) -> User{
		let user = User(isSelf: state.getIsSelfState(),
						userUUID: String(describing: UUID()),
						userMessages: [createNewMessage(messagePayload: messagePayload, imagePayload: imagePayload)])
		return user
	}
	func createNewMessage(messagePayload: MessageTypePayload?, imagePayload: ImageTypePayload?) -> MessagePayload{
		let timeStamp = NSTimeIntervalSince1970
		let newMessage = MessagePayload(
			timeStamp: timeStamp,
			messageUUID: String(describing: UUID()),
			messageTypePayload: messagePayload,
			imageTypePayload: imagePayload
		)
		return newMessage
	}
	
	
	// handles posting of a new chatroom at the topLevel entity
	func postNewChatMessage() {
		let payload = MessageTypePayload(messageText: state.getTextFieldState())
		let chatMessage = createNewChatMessageWithPayloadType (messageTypePayload: payload, imageTypePayload: nil, messsageType: MessageType.text)
		let encoder = JSONEncoder()
		
		guard let newChatMessage = try? encoder.encode(chatMessage) else {return}
		apiHandler.postNewChatMessage(data: newChatMessage) {
					print("POSTED NEW CHAT MESSAGE LIKE MALONE !! ----")
			
			
			
					self.apiHandler.getMessagesFromChatRoom { arrayOfMessages in
		
						print(arrayOfMessages.self.prettyPrintedJSONString!)
						
						let decoder = JSONDecoder()
						guard let safeData = try? decoder.decode(DecodedArray<ReturnedChatMessages>.self, from: arrayOfMessages) else { print("COULDNT DECODE CHAT MESSAGE RESPONSE ENTITY FROM CHATROOM");return}
						let decodedArray = safeData.getArray()
			
						decodedArray.forEach { [self] returnedChatMessage in
							
							let senderIsSelf = self.checkSelf(messageSent: chatMessage, responseMessageFromServer: returnedChatMessage)
							
							if senderIsSelf {
								
								switch self.checkMessageType(responseMessageFromServer: returnedChatMessage) {
								case .message:
									let person = Person(choosePerson: .personOne, message: returnedChatMessage.chatMessagePayload.messageTypePayload!.messageText)
									DispatchQueue.main.async {
										self.state.addViewModelToDisplayState(person: person)
										self.resetTextField?()
										self.reloadView!()
									}
									
								case .image:
									let person = Person(choosePerson: .personOne, message: returnedChatMessage.chatMessagePayload.imageTypePayload!.imageUrl)
									DispatchQueue.main.async {
										self.state.addViewModelToDisplayState(person: person)
										resetTextField?()
										self.reloadView!()
									}
									
								}
								
								
							} else {
								switch self.checkMessageType(responseMessageFromServer: returnedChatMessage) {
								case .message:
									let person = Person(choosePerson: .PersonTWo, message: returnedChatMessage.chatMessagePayload.messageTypePayload!.messageText)
									DispatchQueue.main.async {
										self.state.addViewModelToDisplayState(person: person)
										resetTextField?()
										self.reloadView!()
									}
									
								case .image:
									let person = Person(choosePerson: .PersonTWo, message: returnedChatMessage.chatMessagePayload.imageTypePayload!.imageUrl)
									DispatchQueue.main.async {
										self.state.addViewModelToDisplayState(person: person)
										resetTextField?()
										self.reloadView!()
									}
							}
							
							
							}
							
						}
					}
				}
	}
	
	func checkMessageType(responseMessageFromServer: ReturnedChatMessages) -> PayloadType {
		if responseMessageFromServer.messageType == MessageType.text {
			return .message
		} else {
			return .image
		}
		
	}
	func checkSelf(messageSent: ChatMessage,responseMessageFromServer: ReturnedChatMessages) ->Bool {
		if messageSent.chatMessageUUID == responseMessageFromServer.chatMessageUUID {
			return true
		} else {
			return false
		}
	}
	func putNewChatroom() {
		let messagePayload = MessageTypePayload(messageText: state.getTextFieldState())
		let chatMessage = createNewChatMessageWithPayloadType (messageTypePayload: messagePayload, imageTypePayload: nil, messsageType: MessageType.text)
		let chatRoom = ChatRoom(chatroomMessages: [chatMessage], chatRoomUUID: String(describing: UUID()))
		let chatRoomEntity = ChatRoomCodableEntity(chatrooms: [chatRoom])
		
		let encoder = JSONEncoder()
		guard let safeData = try? encoder.encode(chatRoomEntity) else {print("COULDNT ENCODE CHAT ROOM DATA") ; return}
		apiHandler.createNewChatroom(data: safeData) {
			
			print("PUT NEW CHAT ROOM AT BASE URL")
			
			
		}
	}
}
