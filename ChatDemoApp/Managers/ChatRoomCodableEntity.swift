//
//  ChatRoomCodableEntity.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/11/21.
//

import Foundation


struct ChatRoomCodableEntity: Codable {
	let messages: [ChatMessage]
	let uuid: String
}
// message" will need to have its own uuid, payload, messageType, and fromUserId

struct ChatMessage: Codable {
	let user: User
	let messageType: String
	let timeStamp: Double
	let uuid: String
	let messagePayload: Message
}
struct User: Codable {
	let isSelf: Bool
	let uuid: String
	let messages: [Message]
}
struct Message: Codable {
	let timeStamp: Double
	let uuid: String
	let messagePayload: MessagePayload?
	let imagePayload: ImagePayload?
}

struct ImagePayload : Codable {
	let imageUrl: String
}

struct MessagePayload : Codable {
	let messageText: String
}


struct Person {
	let user: User
	let choosePerson: ChoosePerson
	let message: String 
}
