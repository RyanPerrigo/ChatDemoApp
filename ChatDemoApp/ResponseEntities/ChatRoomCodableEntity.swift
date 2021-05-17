//
//  ChatRoomCodableEntity.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/11/21.
//

import Foundation


struct ChatRoom: Codable {
	let chatroomMessages: [ChatMessage]
	let chatRoomUUID: String
}

struct ChatRoomCodableEntity: Codable {
	let chatrooms: [ChatRoom]
}
// message" will need to have its own uuid, payload, messageType, and fromUserId
struct ChatMessageResponseEntity: Codable {
	let messages: [ChatMessage]
}

// this is the chat message struct that is sent and decoded
struct ChatMessage: Codable {
	let user: User
	let messageType: String
	let timeStamp: Double
	let chatMessageUUID: String
	let chatMessagePayload: MessagePayload
}

struct User: Codable {
	let isSelf: Bool
	let userUUID: String
	let userMessages: [MessagePayload]
}
struct MessagePayload: Codable {
	let timeStamp: Double
	let messageUUID: String
	let messageTypePayload: MessageTypePayload?
	let imageTypePayload: ImageTypePayload?
}

struct ImageTypePayload : Codable {
	let imageUrl: String
}

struct MessageTypePayload : Codable {
	let messageText: String
}


struct Person {
//	let user: User
	let choosePerson: ChoosePerson
	let message: String 
}
