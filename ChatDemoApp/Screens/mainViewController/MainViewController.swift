//
//  MainViewController.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/7/21.
//

import UIKit

class MainViewController: UIViewController, Coordinating {
	

	@IBOutlet weak var button: UIButton!
	@IBAction func goButtonTapped(_ sender: Any) {
		coordinator?.navigationController?.pushViewController(SecondViewController(), animated: true)
	}
	
	var coordinator: Coordinator?
	

    override func viewDidLoad() {
        super.viewDidLoad()
		button.layer.borderWidth = 1
		button.layer.borderColor = UIColor.white.cgColor
		button.layer.backgroundColor = UIColor.black.cgColor
		button.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
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


class MainViewControllerModel {
	
	
	func goButtonTapped() {
		
	}
}
