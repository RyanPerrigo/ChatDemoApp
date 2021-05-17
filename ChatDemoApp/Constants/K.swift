//
//  K.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/11/21.
//

import UIKit


struct K {
	static let post = "POST"
	static let get = "GET"
	static let push = "PUSH"
	static let chatPlaceHolderText = "iChatz"
	
	struct CustomFonts {
		static let customExtraBoldFont = "Custom-ExtraBold"
		static let customSemiBold = "Nunito-SemiBold"
	}
}

struct MessageType {
	static let text = "Text"
	static let picture = "Picture"
	static let special = "Special"
}
struct URLENDPOINTS {
	static let base = "https://ichatz-b4c1d-default-rtdb.firebaseio.com"
	static let chatMessages = base + "/-M_c0dLGQguBtA_j47ZG/messages.json"
	static let individualChatroomMessages = base + "/chatrooms/0/messages.json"
	static let topLevel = base + "/.json"
}


