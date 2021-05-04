//
//  MainCoordinator.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/3/21.
//

import UIKit


class MainCoordinator: Coordinator {
	
	var navigationController: UINavigationController?
	
	func start() {
		var vc: UIViewController & Coordinating = ViewController()
		vc.coordinator = self
		
		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
				 UINavigationBar.appearance().shadowImage = UIImage()
				 UINavigationBar.appearance().backgroundColor = .clear
		UINavigationBar.appearance().backIndicatorImage = UIImage()
		
		
		navigationController?.setViewControllers([vc], animated: false)
	}
	
	
	func eventOccured(with type: Event) {
		switch type {
		case .buttonTapped:
			let vc: SecondViewController & Coordinating = SecondViewController()
			vc.coordinator = self
			navigationController?.pushViewController(vc, animated: true)
				}
	}
	
	
}
