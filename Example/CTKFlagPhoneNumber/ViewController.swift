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
		// Bundle.FlagIcons = Bundle(for: ViewController.self)

		let items = [
			UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: nil),
			UIBarButtonItem(title: "Item 1", style: .plain, target: self, action: nil),
			UIBarButtonItem(title: "Item 2", style: .plain, target: self, action: nil)
		]
		
		phoneNumberTextField = CTKFlagPhoneNumberTextField(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 16, height: 50))
		phoneNumberTextField.flagSize = CGSize(width: 44, height: 44)
		phoneNumberTextField.flagButtonEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10)
		phoneNumberTextField.parentViewController = self
		phoneNumberTextField.textFieldInputAccessoryView = getCustomTextFieldInputAccessoryView(with: items)

		phoneNumberTextField.center = view.center
		phoneNumberTextField.setFlag(with: "FR")
		phoneNumberTextField.set(phoneNumber: "0600000001")
		
		view.addSubview(phoneNumberTextField)

		let button = UIButton(type: .system)
		
		button.frame = CGRect(x: 0, y: 0, width: 50, height: 44)
		button.center = CGPoint(x: view.center.x, y: view.center.y + 60)
		button.setTitle("Ok", for: .normal)
		button.addTarget(self, action: #selector(validate), for: .touchUpInside)

		view.addSubview(button)
	}
	
	private func getCustomTextFieldInputAccessoryView(with items: [UIBarButtonItem]) -> UIToolbar {
		let toolbar: UIToolbar = UIToolbar()
		
		toolbar.barStyle = UIBarStyle.default
		toolbar.items = items
		toolbar.sizeToFit()
		
		return toolbar
	}

	
	@objc func validate() {
		print(phoneNumberTextField.getFormattedPhoneNumber() ?? "No formatted phone number")
		print(phoneNumberTextField.getCountryPhoneCode() ?? "No country phone code")
		print(phoneNumberTextField.getRawPhoneNumber() ?? "No raw phone number")
	}
}

