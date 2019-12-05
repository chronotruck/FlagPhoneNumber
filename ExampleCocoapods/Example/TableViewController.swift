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

	var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
	var repository: FPNCountryRepository = FPNCountryRepository()

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "In Table View"
		tableView.delaysContentTouches = false

		firstPhoneNumberTextField.displayMode = .picker
		firstPhoneNumberTextField.delegate = self

		secondPhoneNumberTextField.displayMode = .list
		secondPhoneNumberTextField.delegate = self

		listController.setup(repository: secondPhoneNumberTextField.countryRepository)

		listController.didSelect = { [weak self] country in
			self?.secondPhoneNumberTextField.setFlag(countryCode: country.code)
		}
	}

	@objc func dismissCountries() {
		listController.dismiss(animated: true, completion: nil)
	}
}

extension TableViewController: FPNTextFieldDelegate {

	func fpnDisplayCountryList() {
		let navigationViewController = UINavigationController(rootViewController: listController)

		listController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissCountries))

		self.present(navigationViewController, animated: true, completion: nil)
	}

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
