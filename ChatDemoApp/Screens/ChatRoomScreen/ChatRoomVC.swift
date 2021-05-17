//
//  SecondViewController.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/3/21.
//

import UIKit

class ChatRoomVC: UIViewController, Coordinating, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextViewDelegate {
	
	@IBOutlet var topLevelView: UIView!
	@IBAction func onSwapPressed(_ sender: Any) {
		viewModel.onSwapPressed()
	}
	@IBOutlet weak var textInputView: UIView!
	@IBOutlet weak var textField: UITextView!
	
	@IBOutlet weak var collectionView: UICollectionView!
	@IBAction func sendButtonClicked(_ sender: Any) {
		viewModel.onSendButtonClicked()
		dismissKeyboard()
	}
	@IBOutlet weak var chatItemsContainerView: UIView!
	
	@IBOutlet weak var textInputViewHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var textInputViewBottomConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
	
	private var viewModel: ChatRoomVM = ChatRoomVM()
	var coordinator: Coordinator?
	
	@objc func goBack() {
		coordinator?.navigationController?.popViewController(animated: true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = K.chatPlaceHolderText
		navigationItem.backBarButtonItem?.action = #selector(goBack)
		
		textField.text = K.chatPlaceHolderText
		setViewHeightToStringSize(constraint: textInputViewHeightConstraint, string: textField.text, optionalSizeIncrease: 50)
		
		chatItemsContainerView.layer.borderWidth = 2
		chatItemsContainerView.layer.borderColor = UIColor.lightGray.cgColor
		chatItemsContainerView.layer.cornerRadius = 12
		textField.layer.cornerRadius = 4
		collectionView.backgroundColor = UIColor.black
		textField.backgroundColor = UIColor.clear
		textField.textColor = UIColor.lightGray
		collectionViewBottomConstraint.constant = textInputViewHeightConstraint.constant
		collectionView.register(UINib(nibName:"PersonOneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:PersonOneCollectionViewCell.identifier)
		collectionView.register(UINib(nibName:"PersonTwoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:PersonTwoCollectionViewCell.identifier)
		
		
		collectionView.dataSource = self
		collectionView.delegate = self
		
		// Do any additional setup after loading the view.
		textField.delegate = self
		
		viewModel.resetTextField = {
			self.textField.text = ""
			self.viewModel.state.setTextFieldState(text: "")
		}
		viewModel.reloadView = {
			self.collectionView.reloadData()
		}
		viewModel.state.updateDisplayCallBack = {
			self.collectionView.reloadData()
		}
		let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
		
		view.addGestureRecognizer(tap)
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidEngage), name: UIResponder.keyboardDidShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidDisEngage), name: UIResponder.keyboardDidHideNotification, object: nil)
	}
	
	@objc func keyboardDidDisEngage() {
		dismissKeyboard()
	}
	@objc func keyboardDidEngage(notification: NSNotification) {
		guard let info = notification.userInfo else {return}
		guard let viewContainer = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
		let keyboardFrame = viewContainer.cgRectValue
		inputView?.translatesAutoresizingMaskIntoConstraints = false
		//
		let keyboardSize = keyboardFrame.size.height
		textInputViewBottomConstraint.constant = keyboardSize
		collectionViewBottomConstraint.constant = keyboardSize + 75
		print(keyboardSize)
		
	}
	@objc func dismissKeyboard() {
		//Causes the view (or one of its embedded text fields) to resign the first responder status.
		textInputViewBottomConstraint.constant = 0
		collectionViewBottomConstraint.constant = 0
		view.endEditing(true)
		if textField.text == "" {
			textField.textColor = .lightGray
			textField.text = K.chatPlaceHolderText
			viewModel.state.setTextFieldState(text: "")
			setViewHeightToStringSize(constraint: textInputViewHeightConstraint, string: textField.text, optionalSizeIncrease: 50)
		}

	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.state.getViewModelDisplayState().count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let position = indexPath.item
		
		let person = viewModel.state.getViewModelDisplayState()[position]
		
		
		switch person.choosePerson {
		case .personOne:
			let dequeCell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonOneCollectionViewCell.identifier, for: indexPath)
			guard let personOneCell = dequeCell as? PersonOneCollectionViewCell else { fatalError("FAIL TO LOAD PERSON ONE CELL")}
			
			personOneCell.setMessageText(person: person)
			return personOneCell
		case .PersonTWo:
			let dequeCell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonTwoCollectionViewCell.identifier, for: indexPath)
			guard let personTwoCell = dequeCell as? PersonTwoCollectionViewCell else { fatalError("FAIL TO LOAD PERSON ONE CELL")}
			
			personTwoCell.setMessageText(person: person)
			return personTwoCell
		}
		
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		
		let person = viewModel.state.getViewModelDisplayState()[indexPath.item]
		let width: CGFloat = UIScreen.main.bounds.width * 0.95
		guard let safeFont = UIFont(name: K.CustomFonts.customSemiBold, size: 12) else {fatalError("Failed to get font at sizeForItemAt")}

		let height: CGFloat = person.message.height(withConstrainedWidth: view.bounds.width, font: safeFont) + 50
		
		switch person.choosePerson {
		case .personOne:
			
			return CGSize(width:width, height: height)
		default :
			return CGSize(width:width, height: height)
		}
		
	}
	func textViewDidChange(_ textView: UITextView) {
		setViewHeightToStringSize(constraint: textInputViewHeightConstraint, string: textView.text, optionalSizeIncrease: 50)
		//setViewHeightToStringSize(constraint: textFieldHeightConstraint, string: textView.text, optionalSizeIncrease: 25)
		
		
		viewModel.state.setTextFieldState(text: textView.text)
		print(viewModel.state.getTextFieldState())
		
		
	}
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.textColor == .lightGray {
			textView.text = ""
			textView.textColor = .white
		}
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		
		if textView.text == "" {
			textView.textColor = .lightGray
			let defaultString = "iChatz"
			textView.text = defaultString
			viewModel.state.setTextFieldState(text: "")
			setViewHeightToStringSize(constraint: textInputViewHeightConstraint, string: textView.text, optionalSizeIncrease: 50)
		}
		
	}
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if (text == "\n") {
			viewModel.onSendButtonClicked()
			setViewHeightToStringSize(constraint: textInputViewHeightConstraint, string: textView.text, optionalSizeIncrease: 50)
			textView.resignFirstResponder()
			dismissKeyboard()
		}
		return true
	}
	
	func setViewHeightToStringSize(constraint: NSLayoutConstraint, string: String, optionalSizeIncrease: CGFloat?) {
		
		guard let font = UIFont(name: K.CustomFonts.customSemiBold, size: 12) else {fatalError("NO FONT AGAIN")}
		let safeSize: CGFloat = optionalSizeIncrease ?? 0
		
		constraint.constant = string.height(withConstrainedWidth: UIScreen.main.bounds.width, font: font) + 15 + safeSize
	}
}
