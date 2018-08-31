//
//  ViewController.swift
//  CTKFlagPhoneNumber
//
//  Created by grifas on 06/08/2017.
//  Copyright (c) 2017 grifas. All rights reserved.
//

import UIKit
import CTKFlagPhoneNumber

class ViewController: UIViewController {

	var phoneNumberTextField: CTKFlagPhoneNumberTextField!

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "CTKFlagPhoneNumber"

		// To use your own flag icons, uncommment the line :
		//		Bundle.FlagIcons = Bundle(for: ViewController.self)

		phoneNumberTextField = CTKFlagPhoneNumberTextField(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 16, height: 50))
		phoneNumberTextField.borderStyle = .roundedRect

		// Comment this line to not have access to the country list
//		phoneNumberTextField.parentViewController = self
		phoneNumberTextField.flagPhoneNumberDelegate = self

		// Custom the size/edgeInsets of the flag button
		phoneNumberTextField.flagSize = CGSize(width: 35, height: 35)
		phoneNumberTextField.flagButtonEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

		// Example of customizing the textField input accessory view
		let items = [
			UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: nil),
			UIBarButtonItem(title: "Item 1", style: .plain, target: self, action: nil),
			UIBarButtonItem(title: "Item 2", style: .plain, target: self, action: nil)
		]
		phoneNumberTextField.textFieldInputAccessoryView = getCustomTextFieldInputAccessoryView(with: items)

		// The placeholder is an example phone number of the selected country by default. You can add your own placeholder :
		//		phoneNumberTextField.hasPhoneNumberExample = false
		//		phoneNumberTextField.placeholder = "Phone Number"

		// Set the flag image with a region code
		//		phoneNumberTextField.setFlag(for: "FR")

		// Set the phone number directly
		//		phoneNumberTextField.set(phoneNumber: "+39054988")

		view.addSubview(phoneNumberTextField)

		phoneNumberTextField.center = view.center
	}

	private func getCustomTextFieldInputAccessoryView(with items: [UIBarButtonItem]) -> UIToolbar {
		let toolbar: UIToolbar = UIToolbar()

		toolbar.barStyle = UIBarStyle.default
		toolbar.items = items
		toolbar.sizeToFit()

		return toolbar
	}
}

extension ViewController: CTKFlagPhoneNumberTextFieldDelegate {

	func didValidatePhoneNumber(textField: CTKFlagPhoneNumberTextField, isValid: Bool) {
		textField.rightViewMode = .always
		textField.rightView = UIImageView(image: isValid ? #imageLiteral(resourceName: "success") : #imageLiteral(resourceName: "error"))

		print(
			isValid,
			textField.getFormattedPhoneNumber(format: .E164),
			textField.getFormattedPhoneNumber(format: .International),
			textField.getFormattedPhoneNumber(format: .National),
			textField.getFormattedPhoneNumber(format: .RFC3966),
			textField.getRawPhoneNumber()
		)
	}

	func didSelectCountry(name: String, dialCode: String, code: String) {
		print(name, dialCode, code)
	}
}
