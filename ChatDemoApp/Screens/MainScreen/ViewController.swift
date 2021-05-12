////
////  ViewController.swift
////  ChatDemoApp
////
////  Created by Ryan Perrigo on 5/2/21.
////
//
//import UIKit
//
////class ViewController: UIViewController, Coordinating {
//
//	var coordinator: Coordinator?
//
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		view.backgroundColor = .red
//		title = "NEW WINDOW"
//
//		let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 55))
//		view.addSubview(button)
//		button.center = view.center
//		button.backgroundColor = .green
//	//	button.setTitle("GO BUTTON", for: .normal)
//		button.addTarget(self, action: #selector(didTapButton) , for: .touchUpInside)
//		navigationItem.standardAppearance?.backgroundColor = UIColor.clear
//
//	}
//
//	@objc func didTapButton () {
//		coordinator?.navigationController?.pushViewController(ChatRoomVC(), animated: true)
//		//coordinator?.eventOccured(with: .buttonTapped)
//	}
//
//}
//
