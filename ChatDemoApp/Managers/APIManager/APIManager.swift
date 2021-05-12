//
//  APIManager.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/9/21.
//

import UIKit


class APIManager {
	
	func postRequest(data: Data) {
		let url = URL(string: "https://ichatz-b4c1d-default-rtdb.firebaseio.com/.json")!
		
		var request = URLRequest(url: url)
		
		request.httpMethod = K.post
		
		
		
		request.httpBody = data
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			
			guard let _ = data else {  print("PROBLEM WITH DATA") ; return}
			guard let theResponse = response else { print("PROBLEM WITH THE POST RESPONSE") ; return}
			if let hasError = error {
				print("ERROR POSTING DATA ---- \(hasError.localizedDescription)")
			}
			
			
			print(theResponse.description)
		}
		task.resume()
	}
	
	func getChatRoomData(completionHandler: @escaping (_ data: Data) -> Void) {
		let url = URL(string: "https://ichatz-b4c1d-default-rtdb.firebaseio.com/.json")!
	
		
		
		let task = URLSession.shared.dataTask(with: url) { Data, URLResponse, Error in
			if let data = Data {
				
				print("data --- \(data.description.utf8)")
					completionHandler(data)
			}
			if let urlResponse = URLResponse {
				print("url response -- \(urlResponse)")
			}
			if let error = Error {
				print(error.localizedDescription)
			}
		}
		task.resume()
	}

}
