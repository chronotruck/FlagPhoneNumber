//
//  SimpleViewController.swift
//  FlagPhoneNumber_Example
//
//  Created by Aurelien on 24/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class SimpleViewController: UIViewController {

	@IBOutlet weak var phoneNumberTextField: FPNTextField!

	var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "In Simple View"

		view.backgroundColor = UIColor.groupTableViewBackground

		// To use your own flag icons, uncommment the line :
		//		Bundle.FlagIcons = Bundle(for: SimpleViewController.self)

		phoneNumberTextField.borderStyle = .roundedRect
//		phoneNumberTextField.pickerView.showPhoneNumbers = false
		phoneNumberTextField.displayMode = .list // .picker by default

		listController.setup(repository: phoneNumberTextField.countryRepository)

		listController.didSelect = { [weak self] country in
			self?.phoneNumberTextField.setFlag(countryCode: country.code)
		}

		phoneNumberTextField.delegate = self
		phoneNumberTextField.font = UIFont.systemFont(ofSize: 14)

		// Custom the size/edgeInsets of the flag button
		phoneNumberTextField.flagButtonSize = CGSize(width: 35, height: 35)
		phoneNumberTextField.flagButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

		// Example of customizing the textField input accessory view
		let items = [
			UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: nil),
			UIBarButtonItem(title: "Item 1", style: .plain, target: self, action: nil),
			UIBarButtonItem(title: "Item 2", style: .plain, target: self, action: nil)
		]
		phoneNumberTextField.textFieldInputAccessoryView = getCustomTextFieldInputAccessoryView(with: items)

		// The placeholder is an example phone number of the selected country by default. You can add your own placeholder :
		phoneNumberTextField.hasPhoneNumberExample = true
		phoneNumberTextField.placeholder = "Phone Number"

		// Set the country list
		//		phoneNumberTextField.setCountries(including: [.ES, .IT, .BE, .LU, .DE])

		// Exclude countries from the list
		//		phoneNumberTextField.setCountries(excluding: [.AM, .BW, .BA])

		// Set the flag image with a region code
		phoneNumberTextField.setFlag(countryCode: .FR)

		// Set the phone number directly
		phoneNumberTextField.set(phoneNumber: "+33612345678")

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

	@objc func dismissCountries() {
		listController.dismiss(animated: true, completion: nil)
	}
}

extension SimpleViewController: FPNTextFieldDelegate {

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


	func fpnDisplayCountryList() {
		let navigationViewController = UINavigationController(rootViewController: listController)

		listController.title = "Countries"
		listController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissCountries))

		self.present(navigationViewController, animated: true, completion: nil)
	}
}
