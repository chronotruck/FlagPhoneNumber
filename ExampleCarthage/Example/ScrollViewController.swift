//
//  ScrollViewController.swift
//  FlagPhoneNumber_Example
//
//  Created by Aurelien on 26/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class ScrollViewController: UIViewController {

	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var contentView: UIView!
	@IBOutlet weak var phoneNumberTextField: FPNTextField!

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "In Scroll View"
		contentView.backgroundColor = UIColor.groupTableViewBackground
		scrollView.delaysContentTouches = false

		phoneNumberTextField.displayMode = .picker
		phoneNumberTextField.delegate = self
	}
}

extension ScrollViewController: FPNTextFieldDelegate {

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
