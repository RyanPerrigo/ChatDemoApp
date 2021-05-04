//
//  SecondViewControllerModel.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/4/21.
//

import UIKit


struct SecondViewControllerModel {
	
	
	var holderModels: [UICollectionViewCell] = []
	var onTextEntered: ((String) -> Void )?
	
	func onSendButtonClicked(text: String) {
		print(text)
	}
	mutating func textlistener(textString: String) {
		onTextEntered = { text in
			print(text)
		}
	}
	
}
