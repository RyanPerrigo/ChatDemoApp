//
//  PersonTwoCollectionViewCell.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/7/21.
//

import UIKit

class PersonTwoCollectionViewCell: UICollectionViewCell {
	
	static let identifier = "personTwoCell"
	
	
	@IBOutlet weak var topLevelView: UIView!
	@IBOutlet weak var messageTextLabel: UILabel!
	@IBOutlet weak var youImage: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
		youImage.image = UIImage(named: "YouImage")
		// corner radius 25 makes a circle 8
		youImage.layer.cornerRadius = 25
		topLevelView.layer.backgroundColor = UIColor.purple.cgColor
	
		
		messageTextLabel.textColor = UIColor.white
		messageTextLabel.font = UIFont(name: "NunitoBold", size: 12)
        // Initialization code
    }
	
	
	func setMessageText(person: Person) {
		messageTextLabel.text = person.message
		
	}
}
