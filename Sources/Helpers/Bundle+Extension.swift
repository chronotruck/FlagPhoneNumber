//
//  Bundle+Extension.swift
//  FlagPhoneNumber
//
//  Created by DeviOS on 07/12/2017.
//

import Foundation

public extension Bundle {

	@objc static var FlagIcons = FlagPhoneNumber()

	@objc static func FlagPhoneNumber() -> Bundle {
		let bundle = Bundle(for: FPNTextField.self)

		if let path = bundle.path(forResource: "FlagPhoneNumber", ofType: "bundle") {
			return Bundle(path: path)!
		} else {
			return bundle
		}
	}
}
