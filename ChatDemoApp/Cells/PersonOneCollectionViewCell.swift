//
//  PersonOneCollectionViewCell.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/3/21.
//


protocol viewModelBased {
	var viewModel: PersonOneCollectionViewCellModel? {get set}
}

import UIKit

class PersonOneCollectionViewCell: UICollectionViewCell, viewModelBased {
	var viewModel: PersonOneCollectionViewCellModel?
	
	
	static let identifier = "personOneCell"
	
	
	@IBOutlet weak var meImage: UIImageView!
	
	@IBOutlet weak var textLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        
		meImage.image = UIImage(named: "MeImage")
		self.backgroundColor = UIColor.orange
		
		if let safeText = textLabel.text {
			viewModel?.labelText = safeText
		}
		
    }

}

struct PersonOneCollectionViewCellModel {
	var labelText: String
}
