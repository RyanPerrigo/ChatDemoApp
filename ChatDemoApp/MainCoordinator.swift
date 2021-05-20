//
//  MainCoordinator.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/3/21.
//

import UIKit


class MainCoordinator: Coordinator {
	
	var navigationController: UINavigationController?
// intial func called when the coordinator starts from the storyboard.
	func start() {
		var vc: UIViewController & Coordinating = MainViewController()
		vc.coordinator = self
	// this is how we hide the nav bar default appearance 
		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
				 UINavigationBar.appearance().shadowImage = UIImage()
				 UINavigationBar.appearance().backgroundColor = .clear
		UINavigationBar.appearance().backIndicatorImage = UIImage()
		
		
		navigationController?.setViewControllers([vc], animated: false)
	}
	
	
	func eventOccured(with type: Event) {
		switch type {
		case .buttonTapped:
			let vc: ChatRoomVC & Coordinating = ChatRoomVC()
			vc.coordinator = self
			navigationController?.pushViewController(vc, animated: true)
		case .createNewUserTapped:
			let vc: CreateNewUserVC & Coordinating = CreateNewUserVC()
			vc.coordinator = self
			navigationController?.pushViewController(vc, animated: true)
		case .loginTapped:
			
			print("loggin Tapped Broo")
				}
	}
	
	
}
