//
//  PersonTwoCollectionViewCell.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/7/21.
//

import UIKit

class PersonTwoCollectionViewCell: UICollectionViewCell {
	
	static let identifier = "personTwoCell"
	private let vm = PersonTwoCollectionViewCellModel()
	
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
		messageTextLabel.font = UIFont(name: "Nunito-ExtraBold", size: 12)
		
        // Initialization code
    }

	func setPerson(person: Person) {
		messageTextLabel.text = person.message
		
	}
}

struct PersonTwoCollectionViewCellModel {
	
	var messageText = ""
}
