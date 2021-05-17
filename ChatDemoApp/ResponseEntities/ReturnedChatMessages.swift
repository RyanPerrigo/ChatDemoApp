//
//  ReturnedChatMessages.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/15/21.
//

import Foundation

struct ReturnedChatMessages: Codable {
	
	var messageUUIDFromFireBase: String
	var chatMessagePayload: MessagePayload
	let chatMessageUUID: String
	let messageType: String
	let timeStamp: Double
	var user: User
	
	
	
	
	enum ReturnedChatMessagesCodingKey: CodingKey {
		case user
		case chatMessagePayload
		case chatMessageUUID
		case timeStamp
		case messageType
				 
		}
	
	init(from decoder: Decoder) throws {

		let containerShell = try decoder.container(keyedBy: ReturnedChatMessagesCodingKey.self)
		messageUUIDFromFireBase = containerShell.codingPath.first!.stringValue
		
		chatMessagePayload = try containerShell.decode(MessagePayload.self, forKey: ReturnedChatMessagesCodingKey.chatMessagePayload)
		chatMessageUUID = try containerShell.decode(String.self, forKey: ReturnedChatMessagesCodingKey.chatMessageUUID)
		messageType = try containerShell.decode(String.self, forKey: ReturnedChatMessagesCodingKey.messageType)
		timeStamp = try containerShell.decode(Double.self, forKey: ReturnedChatMessagesCodingKey.timeStamp)
		user = try containerShell.decode(User.self, forKey: ReturnedChatMessagesCodingKey.user)
		// Decode name
		
		// Extract category from coding path
		messageUUIDFromFireBase = containerShell.codingPath.first!.stringValue
		
	}
}
