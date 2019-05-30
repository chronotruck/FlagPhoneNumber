//
//  FlagPhoneNumberTextFieldDelegate.swift
//  FlagPhoneNumber
//
//  Created by Aurélien Grifasi on 06/08/2017.
//  Copyright (c) 2017 Aurélien Grifasi. All rights reserved.
//

import UIKit

@objc
public protocol FPNTextFieldDelegate: UITextFieldDelegate {
	func fpnDidSelectCountry(name: String, dialCode: String, code: String)
	func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool)
	
	func detectWhenFlagIsTapped() // option to do something when the flag is tapped
	
	func detectWhenDoneButtonTapped() // option to do something when the Done button is tapped
	
	func detectWhenTextFieldTapped()  // option to do something when the instance of the fpnTextField is tapped
}
