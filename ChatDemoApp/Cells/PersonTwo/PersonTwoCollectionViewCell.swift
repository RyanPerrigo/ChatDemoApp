//
//  PersonTwoCollectionViewCell.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/7/21.
//

import UIKit

class PersonTwoCollectionViewCell: UICollectionViewCell {
	
	static let identifier = "personTwoCell"
	
	@IBOutlet weak var messageTextLabel: UILabel!
	@IBOutlet weak var youImage: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
		youImage.image = UIImage(named: "YouImage")
		
        // Initialization code
    }

	func setPerson(person: Person) {
		messageTextLabel.text = person.message
		
	}
}
