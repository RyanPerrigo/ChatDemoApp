//
//  SecondViewController.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/3/21.
//

import UIKit

class SecondViewController: UIViewController, Coordinating, UICollectionViewDataSource, UICollectionViewDelegate {
	
	
	private var viewModel: SecondViewControllerModel = SecondViewControllerModel()
	
	@IBOutlet weak var textField: UITextField!
	
	
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	
	@IBAction func onTextEntered(_ sender: Any) {
		if textField.text != nil {
			viewModel.textlistener(textString: textField.text!)
		}
	
	}
	@IBAction func sendButtonClicked(_ sender: Any) {
		
		if let safeText = textField.text {
			viewModel.onSendButtonClicked(text: safeText)
		}
		
	}
	

	
	
	var coordinator: Coordinator?
	

    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Second Screen"
		view.backgroundColor = .blue
		collectionView.register(PersonOneCollectionViewCell.self, forCellWithReuseIdentifier: PersonOneCollectionViewCell.identifier)
		collectionView.dataSource = self
		collectionView.delegate = self
		
        // Do any additional setup after loading the view.
		textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.holderModels.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonOneCollectionViewCell.identifier, for: indexPath)
		return cell
	}
	
	@objc func textFieldDidChange(_ textField: UITextField) {
		print(textField.text)
	}
}
