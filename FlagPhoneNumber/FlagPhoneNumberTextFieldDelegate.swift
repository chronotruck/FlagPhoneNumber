//
//  FlagPhoneNumberTextFieldDelegate.swift
//  FlagPhoneNumber
//
//  Created by Aurélien Grifasi on 06/08/2017.
//  Copyright (c) 2017 Aurélien Grifasi. All rights reserved.
//

import Foundation

public protocol FPNTextFieldDelegate: UITextFieldDelegate {
	func fpnDidSelectCountry(name: String, dialCode: String, code: String)
	func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool)
}
