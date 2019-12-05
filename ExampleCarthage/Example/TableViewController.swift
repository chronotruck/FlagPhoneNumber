//
//  TableViewController.swift
//  FlagPhoneNumber_Example
//
//  Created by Aurelien on 24/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class TableViewController: UITableViewController {

	@IBOutlet weak var firstPhoneNumberTextField: FPNTextField!
	@IBOutlet weak var secondPhoneNumberTextField: FPNTextField!
	@IBOutlet weak var thirdPhoneNumberTextField: FPNTextField!

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "In Table View"
		tableView.delaysContentTouches = false

		firstPhoneNumberTextField.displayMode = .picker
		firstPhoneNumberTextField.delegate = self

		secondPhoneNumberTextField.displayMode = .picker
		secondPhoneNumberTextField.delegate = self

		thirdPhoneNumberTextField.displayMode = .picker
		thirdPhoneNumberTextField.delegate = self
	}
}

extension TableViewController: FPNTextFieldDelegate {

	func fpnDisplayCountryList() {}

	func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
		textField.rightViewMode = .always
		textField.rightView = UIImageView(image: isValid ? #imageLiteral(resourceName: "success") : #imageLiteral(resourceName: "error"))

		print(
			isValid,
			textField.getFormattedPhoneNumber(format: .E164) ?? "E164: nil",
			textField.getFormattedPhoneNumber(format: .International) ?? "International: nil",
			textField.getFormattedPhoneNumber(format: .National) ?? "National: nil",
			textField.getFormattedPhoneNumber(format: .RFC3966) ?? "RFC3966: nil",
			textField.getRawPhoneNumber() ?? "Raw: nil"
		)
	}

	func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
		print(name, dialCode, code)
	}
}
