//
//  Coordinator.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/2/21.
//

import UIKit

enum Event {
	case buttonTapped
	case loginTapped
	case createNewUserTapped
}

protocol Coordinator {
	var navigationController: UINavigationController? { get set}
	
	func start()
	
	func eventOccured(with type: Event)
}


protocol Coordinating {
	var coordinator: Coordinator? {get set}
}
