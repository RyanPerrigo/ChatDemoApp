//
//  DecodedArray.swift
//  ChatDemoApp
//
//  Created by Ryan Perrigo on 5/15/21.
//

import Foundation

struct DecodedArray<T: Decodable>: Decodable {

	// ***
	typealias DecodedArrayType = [T]

	private var array: DecodedArrayType
	
	func getArray() -> [T] {
		return array
	}

	// Define DynamicCodingKeys type needed for creating decoding container from JSONDecoder
	private struct DynamicCodingKeys: CodingKey {
		
		
		
		

		// Use for string-keyed dictionary
		var stringValue: String
		
		
		init?(stringValue: String) {
			self.stringValue = stringValue
		}

		// Use for integer-keyed dictionary
		
		var intValue: Int?
		
		init?(intValue: Int) {
			// We are not using this, thus just return nil
			return nil
		}
	}

	init(from decoder: Decoder) throws {

		// Create decoding container using DynamicCodingKeys
		// The container will contain all the JSON first level key
		let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

		var tempArray = DecodedArrayType()

		// Loop through each keys in container
		for key in container.allKeys {

			// ***
			// Decode T using key & keep decoded T object in tempArray
			let decodedStringObject = try container.decode(T.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
			tempArray.append(decodedStringObject)
			
		}
		
		// Finish decoding all T objects. Thus assign tempArray to array.
		array = tempArray
	}
	
}
