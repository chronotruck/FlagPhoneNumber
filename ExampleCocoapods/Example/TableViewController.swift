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

		firstPhoneNumberTextField.parentViewController = self
		firstPhoneNumberTextField.delegate = self

		secondPhoneNumberTextField.parentViewController = self
		secondPhoneNumberTextField.delegate = self

		thirdPhoneNumberTextField.parentViewController = self
		thirdPhoneNumberTextField.delegate = self
	}
}

extension TableViewController: FPNTextFieldDelegate {

	func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
		textField.rightViewMode = .always
		textField.rightView = UIImageView(image: isValid ? #imageLiteral(resourceName: "success") : #imageLiteral(resourceName: "error"))

		print("isValid       : ", isValid)
		print("E164          : ", textField.getPhoneNumber(in: .E164) ?? "nil")
		print("International : ", textField.getPhoneNumber(in: .International) ?? "nil")
		print("National      : ", textField.getPhoneNumber(in: .National) ?? "nil")
		print("Raw           : ", textField.getPhoneNumber(in: .Raw) ?? "nil")
		print("\n")
	}

	func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
		print(name, dialCode, code)
	}
}
