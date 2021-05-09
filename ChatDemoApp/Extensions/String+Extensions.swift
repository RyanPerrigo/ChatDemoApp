//
//  String+Extensions.swift
//  
//
//  Created by Ryan Perrigo on 5/7/21.
//

import UIKit

extension String {
	func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
	
		return ceil(boundingBox.height)
	}

	func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

		return ceil(boundingBox.width)
	}
}
func setViewHeightToStringSize(constraint: NSLayoutConstraint, string: String, optionalSizeIncrease: CGFloat?) {
	let font = UIFont(name: "Nunito-ExtraBold", size: 12) ?? UIFont.systemFont(ofSize: 12)
	let safeSize: CGFloat = optionalSizeIncrease ?? 0
	
	constraint.constant = string.height(withConstrainedWidth: UIScreen.main.bounds.width, font: font) + 15 + safeSize
}
