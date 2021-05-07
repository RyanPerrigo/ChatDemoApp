//
//  PersonOneCollectionViewCell.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/3/21.
//



import UIKit

class PersonOneCollectionViewCell: UICollectionViewCell {
	
	static let identifier = "personOneCell"
	
	@IBOutlet weak var meImage: UIImageView!
	@IBOutlet weak var textLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
		meImage.image = UIImage(named: "MeImage")
		self.backgroundColor = UIColor.orange
		
    }
	
	func setPerson(person: Person) {
		textLabel.text = person.message
	}
	
}

