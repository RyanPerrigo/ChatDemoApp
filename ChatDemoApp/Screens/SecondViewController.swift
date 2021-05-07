//
//  SecondViewController.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/3/21.
//

import UIKit

class SecondViewController: UIViewController, Coordinating, UICollectionViewDataSource, UICollectionViewDelegate {
	
	@IBAction func onSwapPressed(_ sender: Any) {
		viewModel.onSwapPressed()
	}
	
	private var viewModel: SecondViewControllerModel = SecondViewControllerModel()
	
	@IBOutlet weak var textField: UITextField!
	

	
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	@IBAction func sendButtonClicked(_ sender: Any) {
		viewModel.onSendButtonClicked()
	}
	
	
	
	
	var coordinator: Coordinator?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Second Screen"
		view.backgroundColor = .blue

		
		collectionView.register(UINib(nibName:"PersonOneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:PersonOneCollectionViewCell.identifier)
		collectionView.register(UINib(nibName:"PersonTwoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:PersonTwoCollectionViewCell.identifier)

		
		collectionView.dataSource = self
		collectionView.delegate = self
		
		// Do any additional setup after loading the view.
		textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//		viewModel.onTextFieldChanged = { [self] text in
//			viewModel.textFieldState = text
//		}
		viewModel.resetTextField = {
			self.textField.text = ""
		}
		viewModel.reloadView = {
			self.collectionView.reloadData()
		}
	}
	
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.state.getViewModelDisplayState().count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let position = indexPath.item
		
		let person = viewModel.state.getViewModelDisplayState()[position]
		
		
		switch person.isSelf {
		case .personOne:
			
			let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonOneCollectionViewCell.identifier, for: indexPath)

			guard let meCell = dequeuedCell as? PersonOneCollectionViewCell else {
			  fatalError("FAILED TO LOAD ME CELL")
			}
			
			meCell.setPerson(person: person)
			return meCell
		case .PersonTWo:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonTwoCollectionViewCell.identifier, for: indexPath)
			guard let youCell = cell as? PersonTwoCollectionViewCell else { fatalError("FAILED TO LOAD YOU CELL")}
			youCell.setPerson(person: person)
			return youCell
		}
	}
	
	@objc func textFieldDidChange(_ textField: UITextField) {
		if let safeText = textField.text {
			viewModel.state.setTextFieldState(text: safeText)
		}
		
	}
}
