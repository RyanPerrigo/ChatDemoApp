//
//  PersonOneCollectionViewCell.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/3/21.
//


import UIKit

class PersonOneCollectionViewCell: UICollectionViewCell {
	
	static let identifier = "personOneCell"
	
	@IBOutlet weak var topLevelView: UIView!
	@IBOutlet weak var meImage: UIImageView!
	@IBOutlet weak var textLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		textLabel.font = UIFont(name: "Nunito-ExtraBold", size: 12)
		meImage.layer.cornerRadius = 8
		meImage.image = UIImage(named: "MeImage")
		textLabel.textColor = UIColor.black
		topLevelView.layer.backgroundColor = UIColor.cyan.cgColor
		
    }
	
	func setMessageText(person: Person) {
		textLabel.text = person.message
	}
	
}



