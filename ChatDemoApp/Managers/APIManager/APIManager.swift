//
//  APIManager.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/9/21.
//

import UIKit


class APIManager {
	
	func postNewChatMessage(data: Data, completionHandler: @escaping () -> Void) {
		let url = URL(string: URLENDPOINTS.individualChatroomMessages)!
		var request = URLRequest(url: url)
		request.httpMethod = K.post
		request.httpBody = data
		
		let task = URLSession.shared.dataTask(with: request) { data,webResponse,Error  in
			
			guard let _ = data else {print("PROBLEM WITH POSTING DATA ---") ; return}
			if let hasError = Error {
				print("ERROR POSTING DATA --- \(hasError.localizedDescription)")
			}
			completionHandler()
		}
		task.resume()
	}
	func createNewChatroom(data: Data, completionHandler: @escaping () -> Void) {
		let url = URL(string: URLENDPOINTS.topLevel)!
		
		var request = URLRequest(url: url)
		
		request.httpMethod = "PUT"
		request.httpBody = data
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			
			guard let _ = data else {  print("PROBLEM WITH DATA") ; return}
			guard let theResponse = response else { print("PROBLEM WITH THE POST RESPONSE") ; return}
			if let hasError = error {
				print("ERROR POSTING DATA ---- \(hasError.localizedDescription)")
			}
			
			completionHandler()
			print(theResponse.description)
		}
		task.resume()
		
	}
	
	func getChatRoomData(completionHandler: @escaping (_ data: Data) -> Void) {
		let url = URL(string: "https://ichatz-b4c1d-default-rtdb.firebaseio.com/.json")!
		
		
		
		let task = URLSession.shared.dataTask(with: url) { Data, URLResponse, Error in
			
			guard let data = Data else {return}
			guard let _ = URLResponse else {return}
			if let error = Error {
				print(error.localizedDescription)
			}
			completionHandler(data)
		}
		task.resume()
	}
	func getMessagesFromChatRoom(completionHandler: @escaping (_ data: Data) -> Void ) {
		let url = URL(string: URLENDPOINTS.individualChatroomMessages)!
		
		let task = URLSession.shared.dataTask(with: url) { data, urlResp, Error in
			guard let safeData = data else { print("ERROR GETTING CHATMESSAGES FROM CHATROOM") ; return}
			if let error = Error {
				print(error.localizedDescription)
			}
			completionHandler(safeData)
		}
		task.resume()
	}
	
}
