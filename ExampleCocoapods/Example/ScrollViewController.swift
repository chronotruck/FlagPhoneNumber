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

		phoneNumberTextField.parentViewController = self
		phoneNumberTextField.delegate = self
	}
}

extension ScrollViewController: FPNTextFieldDelegate {

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
