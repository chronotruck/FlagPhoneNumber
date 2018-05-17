//
//  Bundle+Extension.swift
//  CTKFlagPhoneNumber
//
//  Created by DeviOS on 07/12/2017.
//

import Foundation

extension Bundle {
	static public var FlagIcons = CTKFlagPhoneNumber()
	
	static public func CTKFlagPhoneNumber() -> Bundle {
		let bundle = Bundle(for: CTKFlagPhoneNumberTextField.self)
		
		if let url = bundle.resourceURL?.appendingPathComponent("CTKFlagPhoneNumber.bundle") {
			return Bundle(url: url)!
		} else {
			return bundle
		}
	}
}
