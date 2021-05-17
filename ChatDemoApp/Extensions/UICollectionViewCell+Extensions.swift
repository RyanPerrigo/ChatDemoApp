//
//  UICollectionViewCell+Extensions.swift
//  
//
//  Created by Ryan Perrigo on 5/7/21.
//

import UIKit


extension UICollectionViewCell {
	
	func shadowDecorate(cornerRadius: CGFloat) {
		
		contentView.layer.cornerRadius = cornerRadius
		contentView.layer.borderWidth = 0.5
		contentView.layer.borderColor = UIColor.clear.cgColor
		contentView.layer.masksToBounds = true
	
		layer.shadowColor = UIColor.darkGray.cgColor
		layer.shadowOffset = CGSize(width: 0.4, height: 0.3)
		layer.shadowRadius = 5
		layer.shadowOpacity = 0.6
		layer.masksToBounds = false
		layer.cornerRadius = cornerRadius
	}
	
	
}
