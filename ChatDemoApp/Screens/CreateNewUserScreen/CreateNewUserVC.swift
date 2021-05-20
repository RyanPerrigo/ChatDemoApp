//
//  CreateNewUserVC.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/12/21.
//

import UIKit

class CreateNewUserVC: UIViewController, Coordinating, UITextFieldDelegate {
	
	var coordinator: Coordinator?
	
	private let vm = CreateNewUserVCM()
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	@IBAction func enterClicked(_ sender: Any) {
		print("EnterClicked")
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		emailTextField.addTarget(self, action: #selector(self.onEmailTextEntered), for: .editingChanged)
		passwordTextField.addTarget(self, action: #selector(self.onPasswordTextEntered), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
	@objc func onEmailTextEntered() {
	 
		guard let safeText = emailTextField.text else {return}
		
		vm.state.setEmailState(text: safeText)
	}

	@objc func onPasswordTextEntered() {
		guard let safeText = passwordTextField.text else {return}
		vm.state.setPasswordState(text: safeText)
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
