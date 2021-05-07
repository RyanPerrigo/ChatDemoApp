//
//  SecondViewController.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/3/21.
//

import UIKit

class SecondViewController: UIViewController, Coordinating, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextViewDelegate {
	
	@IBAction func onSwapPressed(_ sender: Any) {
		viewModel.onSwapPressed()
	}
	
	private var viewModel: SecondViewControllerModel = SecondViewControllerModel()
	
		
	@IBOutlet weak var textField: UITextView!
	
	
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	@IBAction func sendButtonClicked(_ sender: Any) {
		viewModel.onSendButtonClicked()
	}
	
	
	
	
	var coordinator: Coordinator?
	@objc func goBack() {
		coordinator?.navigationController?.popViewController(animated: true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Chatz"
		navigationItem.backBarButtonItem?.action = #selector(goBack)
		

		textField.layer.cornerRadius = 4
		collectionView.backgroundColor = UIColor.lightGray
		collectionView.register(UINib(nibName:"PersonOneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:PersonOneCollectionViewCell.identifier)
		collectionView.register(UINib(nibName:"PersonTwoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:PersonTwoCollectionViewCell.identifier)

		
		collectionView.dataSource = self
		collectionView.delegate = self
		
		// Do any additional setup after loading the view.
		textField.delegate = self
		
		viewModel.resetTextField = {
			self.textField.text = ""
		}
		viewModel.reloadView = {
			self.collectionView.reloadData()
		}
		let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))

			//Uncomment the line below if you want the tap not not interfere and cancel other interactions.
			//tap.cancelsTouchesInView = false

			view.addGestureRecognizer(tap)

		//Calls this function when the tap is recognized.
		
	}
	
	@objc func dismissKeyboard() {
		//Causes the view (or one of its embedded text fields) to resign the first responder status.
		view.endEditing(true)
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
			meCell.shadowDecorate(cornerRadius: 4)
			meCell.setPerson(person: person)
			return meCell
		case .PersonTWo:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonTwoCollectionViewCell.identifier, for: indexPath)
			guard let youCell = cell as? PersonTwoCollectionViewCell else { fatalError("FAILED TO LOAD YOU CELL")}
			youCell.setPerson(person: person)
			youCell.shadowDecorate(cornerRadius: 4)
			return youCell
		}
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		
		let person = viewModel.state.getViewModelDisplayState()[indexPath.item]

		let width: CGFloat = UIScreen.main.bounds.width * 0.98
		let safeFont = UIFont.systemFont(ofSize: 12)
		
			let height: CGFloat = viewModel.state.getTextFieldState().height(withConstrainedWidth: width, font: safeFont)
			
			switch person.isSelf {
			case .personOne:
				return CGSize(width:width, height: height)
			default:
				return CGSize(width: width, height:height)
			}
		
	}
	func textViewDidChange(_ textView: UITextView) {
		if let safeText = textField.text {
			viewModel.state.setTextFieldState(text: safeText)
		}

	}
	
}
