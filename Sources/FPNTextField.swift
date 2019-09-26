//
//  FPNTextField.swift
//  FlagPhoneNumber
//
//  Created by Aurélien Grifasi on 06/08/2017.
//  Copyright (c) 2017 Aurélien Grifasi. All rights reserved.
//

import UIKit
import PhoneNumberKit

open class FPNTextField: PhoneNumberTextField, FPNCountryPickerDelegate, FPNDelegate {

	/// The size of the flag button
	@objc public var flagButtonSize: CGSize = CGSize(width: 32, height: 32) {
		didSet {
			flagWidthConstraint?.constant = flagButtonSize.width
			flagHeightConstraint?.constant = flagButtonSize.height
			layoutIfNeeded()
		}
	}

	private var flagWidthConstraint: NSLayoutConstraint?
	private var flagHeightConstraint: NSLayoutConstraint?

	/// The size of the leftView
	private var leftViewSize: CGSize {
		let width = flagButtonSize.width + getWidth(text: phoneCodeTextField.text!)
		let height = bounds.height

		return CGSize(width: width, height: height)
	}

	private var phoneCodeTextField: UITextField = UITextField()
	private lazy var countryPicker: FPNCountryPicker = FPNCountryPicker()
	private lazy var phoneUtil: NBPhoneNumberUtil = NBPhoneNumberUtil()

	public var flagButton: UIButton = UIButton()

	open override var font: UIFont? {
		didSet {
			phoneCodeTextField.font = font
		}
	}

	open override var textColor: UIColor? {
		didSet {
			phoneCodeTextField.textColor = textColor
		}
	}

	/// Present in the placeholder an example of a phone number according to the selected country code.
	/// If false, you can set your own placeholder. Set to true by default.
	@objc public var hasPhoneNumberExample: Bool = true {
		didSet {
			if hasPhoneNumberExample {
				updatePlaceholder()
			} else {
				placeholder = nil
			}
		}
	}

	/// If set, a search button appears in the picker inputAccessoryView to present a country search view controller
	@IBOutlet public var parentViewController: UIViewController?

	/// Input Accessory View for the texfield
	@objc public var textFieldInputAccessoryView: UIView?

	init() {
		super.init(frame: .zero)

		setup()
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)

		setup()
	}

	required public init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		setup()
	}

	deinit {
		parentViewController = nil
	}

	private func setup() {
		withPrefix = false
		leftViewMode = .always

		setupFlagButton()
		setupPhoneCodeTextField()
		setupLeftView()
		setupCountryPicker()

		keyboardType = .numberPad
		autocorrectionType = .no
		addTarget(self, action: #selector(didEditText), for: .editingChanged)
		addTarget(self, action: #selector(displayNumberKeyBoard), for: .touchDown)
	}

	private func setupFlagButton() {
		flagButton.imageView?.contentMode = .scaleAspectFit
		flagButton.accessibilityLabel = "flagButton"
		flagButton.addTarget(self, action: #selector(displayCountryKeyboard), for: .touchUpInside)
		flagButton.translatesAutoresizingMaskIntoConstraints = false
		flagButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
	}

	private func setupPhoneCodeTextField() {
		phoneCodeTextField.font = font
		phoneCodeTextField.isUserInteractionEnabled = false
		phoneCodeTextField.translatesAutoresizingMaskIntoConstraints = false
	}

	private func setupLeftView() {
		let wrapperView = UIView()

		wrapperView.addSubview(flagButton)
		wrapperView.addSubview(phoneCodeTextField)

		let views = ["flag": flagButton, "textField": phoneCodeTextField]

		flagWidthConstraint = NSLayoutConstraint(item: flagButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: flagButtonSize.width)
		flagHeightConstraint = NSLayoutConstraint(item: flagButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: flagButtonSize.height)

		flagButton.addConstraint(flagWidthConstraint!)
		flagButton.addConstraint(flagHeightConstraint!)

		wrapperView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[flag][textField]|", options: [], metrics: nil, views: views))
		wrapperView.addConstraint(NSLayoutConstraint(item: flagButton, attribute: .centerY, relatedBy: .equal, toItem: wrapperView, attribute: .centerY, multiplier: 1, constant: 0))
		wrapperView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[textField]|", options: [], metrics: nil, views: views))

		leftView = wrapperView
	}

	open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		let leftViewFrame: CGRect = leftView?.frame ?? .zero
		let size = leftViewSize
		let width: CGFloat = min(bounds.size.width, size.width)
		let height: CGFloat = min(bounds.size.height, size.height)
		let newRect: CGRect = CGRect(x: leftViewFrame.minX, y: leftViewFrame.minY, width: width, height: height)

		return newRect
	}

	private func setupCountryPicker() {
		countryPicker.countryPickerDelegate = self
		countryPicker.showPhoneNumbers = true
		countryPicker.backgroundColor = .white

		if let regionCode = Locale.current.regionCode, let countryCode = FPNCountryCode(rawValue: regionCode) {
			countryPicker.setCountry(countryCode)
		} else if let firstCountry = countryPicker.countries.first {
			countryPicker.setCountry(firstCountry.code)
		}
	}

	// MARK: Selectors

	@objc private func displayNumberKeyBoard() {
		inputView = nil
		inputAccessoryView = textFieldInputAccessoryView
		tintColor = .gray
		reloadInputViews()
	}

	@objc private func displayCountryKeyboard() {
		inputView = countryPicker
		inputAccessoryView = getToolBar(with: getCountryListBarButtonItems())
		tintColor = .clear
		reloadInputViews()
		becomeFirstResponder()
	}

	@objc private func resetKeyBoard() {
		inputView = nil
		inputAccessoryView = nil
		resignFirstResponder()
	}

	@objc private func showSearchController() {
		let searchCountryViewController = FPNSearchCountryViewController(countries: countryPicker.countries)
		let navigationViewController = UINavigationController(rootViewController: searchCountryViewController)

		searchCountryViewController.delegate = self

		parentViewController?.present(navigationViewController, animated: true, completion: nil)
	}

	@objc private func didEditText() {
		(delegate as? FPNTextFieldDelegate)?.fpnDidValidatePhoneNumber(textField: self, isValid: isValidNumber)
	}

	// MARK: Public

	/// Get the phone number in the specified format
	public func getPhoneNumber(in format: FPNFormat) -> String? {
		let rawNumber = self.text ?? String()

		do {
			let phoneNumber = try phoneNumberKit.parse(rawNumber, withRegion: currentRegion)

			switch format {
			case .E164:
				return phoneNumberKit.format(phoneNumber, toType: .e164)
			case .International:
				return phoneNumberKit.format(phoneNumber, toType: .international)
			case .National:
				return phoneNumberKit.format(phoneNumber, toType: .national)
			case .Raw:
				return "\(phoneNumber.nationalNumber)"
			}
		} catch {
			return nil
		}
	}

	/// For Objective-C, Get the phone number in the specified format
	@objc public func getPhoneNumber(in format: Int) -> String? {
		if let format = FPNFormat(rawValue: format) {
			return getPhoneNumber(in: format)
		}
		return nil
	}

	/// Set directly the phone number.
	/// - phoneNumber: The phone number to set. E.g +33612345678
	/// - region: The region of the phone number. Optional.
	///
	/// You can provide the region if the phoneNumber doesn't start by the country code.
	///
	/// Example
	///
	/// phoneNumber: "0612345678", region: "FR"
	public func set(phoneNumber: String, for region: FPNCountryCode? = nil) {
		do {
			var parsedPhoneNumber: PhoneNumber

			if let region = region {
				parsedPhoneNumber = try phoneNumberKit.parse(phoneNumber, withRegion: region.rawValue, ignoreType: false)
				setFlag(for: region)
			} else {
				parsedPhoneNumber = try phoneNumberKit.parse(phoneNumber)

				if let region = parsedPhoneNumber.regionID, let countryCode = FPNCountryCode(rawValue: region) {
					setFlag(for: countryCode)
				}
			}

			text = "\(parsedPhoneNumber.nationalNumber)"
		}
		catch {
			text = phoneNumber
		}
	}

	/// Set directly the phone number.
	/// - phoneNumber: The phone number to set. E.g +33612345678
	/// - region: The region of the phone number. Optional.
	///
	/// You can provide the region if the phoneNumber doesn't start by the country code.
	///
	/// Example
	///
	/// phoneNumber: "0612345678", region: 59
	@objc public func setOBJC(phoneNumber: String) {
		set(phoneNumber: phoneNumber)
	}

	/// Set directly the phone number.
	/// - phoneNumber: The phone number to set. E.g +33612345678
	/// - region: The region of the phone number. Optional.
	///
	/// You can provide the region if the phoneNumber doesn't start by the country code.
	///
	/// Example
	///
	/// phoneNumber: "0612345678", region: 59
	@objc public func setOBJC(phoneNumber: String, for region: Int) {
		var phoneNumberRegion: FPNCountryCode?

		if let key = FPNOBJCCountryKey(rawValue: region), let code = FPNOBJCCountryCode[key], let countryCode = FPNCountryCode(rawValue: code) {
			phoneNumberRegion = countryCode
		}
		set(phoneNumber: phoneNumber, for: phoneNumberRegion)
	}

	/// Set the country list excluding the provided countries
	public func setCountries(excluding countries: [FPNCountryCode]) {
		countryPicker.setup(without: countries)
	}

	/// Set the country list including the provided countries
	public func setCountries(including countries: [FPNCountryCode]) {
		countryPicker.setup(with: countries)
	}

	/// Set the country list excluding the provided countries
	@objc public func setCountries(excluding countries: [Int]) {
		let countryCodes: [FPNCountryCode] = countries.compactMap({ index in
			if let key = FPNOBJCCountryKey(rawValue: index), let code = FPNOBJCCountryCode[key], let countryCode = FPNCountryCode(rawValue: code) {
				return countryCode
			}
			return nil
		})

		countryPicker.setup(without: countryCodes)
	}

	/// Set the country list including the provided countries
	@objc public func setCountries(including countries: [Int]) {
		let countryCodes: [FPNCountryCode] = countries.compactMap({ index in
			if let key = FPNOBJCCountryKey(rawValue: index), let code = FPNOBJCCountryCode[key], let countryCode = FPNCountryCode(rawValue: code) {
				return countryCode
			}
			return nil
		})

		countryPicker.setup(with: countryCodes)
	}

	/// Set the country image according to country code. Example "FR"
	public func setFlag(for countryCode: FPNCountryCode) {
		countryPicker.setCountry(countryCode)
	}

	/// Set the country image according to country code. Example "FR"
	@objc public func setFlag(for key: FPNOBJCCountryKey) {
		if let code = FPNOBJCCountryCode[key], let countryCode = FPNCountryCode(rawValue: code) {
			countryPicker.setCountry(countryCode)
		}
	}

	// MARK: Private

	private func getWidth(text: String) -> CGFloat {
		if let font = phoneCodeTextField.font {
			let fontAttributes = [NSAttributedString.Key.font: font]
			let size = (text as NSString).size(withAttributes: fontAttributes)

			return size.width.rounded(.up)
		} else {
			phoneCodeTextField.sizeToFit()

			return phoneCodeTextField.frame.size.width.rounded(.up)
		}
	}

	private func getToolBar(with items: [UIBarButtonItem]) -> UIToolbar {
		let toolbar: UIToolbar = UIToolbar()

		toolbar.barStyle = UIBarStyle.default
		toolbar.items = items
		toolbar.sizeToFit()

		return toolbar
	}

	private func getCountryListBarButtonItems() -> [UIBarButtonItem] {
		let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resetKeyBoard))

		doneButton.accessibilityLabel = "doneButton"

		if parentViewController != nil {
			let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchController))

			searchButton.accessibilityLabel = "searchButton"

			return [searchButton, space, doneButton]
		}
		return [space, doneButton]
	}

	private func updatePlaceholder() {
		do {
			let examplePhoneNumber = try phoneUtil.getExampleNumber(defaultRegion)
			let exampleCountryCode = examplePhoneNumber.countryCode.stringValue
			let exampleNationalNumber = examplePhoneNumber.nationalNumber.stringValue
			let formattedExamplePhoneNumber = PartialFormatter().formatPartial("+\(exampleCountryCode)\(exampleNationalNumber)")

			placeholder = formattedExamplePhoneNumber.replacingOccurrences(of: "+\(exampleCountryCode) ", with: "")
		} catch _ {
			placeholder = nil
		}
	}

	// MARK: FPNCountryPickerDelegate

	func countryPhoneCodePicker(_ picker: FPNCountryPicker, didSelectCountry country: FPNCountry) {
		(delegate as? FPNTextFieldDelegate)?.fpnDidSelectCountry(name: country.name, dialCode: country.phoneCode, code: country.code.rawValue)
		defaultRegion = country.code.rawValue

		flagButton.setImage(country.flag, for: .normal)
		phoneCodeTextField.text = country.phoneCode

		if hasPhoneNumberExample == true {
			updatePlaceholder()
		}
		text = nil
	}

	// MARK: FPNDelegate

	internal func fpnDidSelect(country: FPNCountry) {
		setFlag(for: country.code)
	}
}
