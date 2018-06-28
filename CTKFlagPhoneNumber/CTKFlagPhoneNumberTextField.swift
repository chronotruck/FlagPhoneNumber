//
//  CTKFlagPhoneNumberTextField.swift
//  CTKFlagPhoneNumber
//
//  Created by Chronotruck on 01/06/2017.
//

import Foundation
import libPhoneNumber_iOS

open class CTKFlagPhoneNumberTextField: UITextField, UITextFieldDelegate, CountryPickerDelegate, CTKFlagPhoneNumberDelegate {
		
	// The size of the flag
	public var flagSize: CGSize = CGSize(width: 32, height: 32) {
		didSet {
			layoutSubviews()
		}
	}
	
	// The edges insets of the flag button
	public var flagButtonEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5) {
		didSet {
			layoutSubviews()
		}
	}
	
	// The size of the leftView
	private var leftViewSize: CGSize {
		let width = flagSize.width + flagButtonEdgeInsets.left + flagButtonEdgeInsets.right + phoneCodeLabel.frame.width
		let height = bounds.height

		return CGSize(width: width, height: height)
	}
	
	public var flagButton: UIButton = UIButton()
	public var phoneCodeLabel: UILabel = UILabel()
	private lazy var countryPicker: CountryPicker = CountryPicker()
	private lazy var phoneUtil: NBPhoneNumberUtil = NBPhoneNumberUtil()
	private var formatter: NBAsYouTypeFormatter?

	private var placeHolder: String? {
		didSet {
			placeholder = placeHolder
		}
	}
	private var phoneNumber: String?
	private var phoneCode: String? {
		didSet {
			phoneCodeLabel.text = phoneCode
			phoneCodeLabel.sizeToFit()
			layoutSubviews()
		}
	}
	private var countryCode: String? {
		didSet {
			if let countryCode = countryCode {
				formatter = NBAsYouTypeFormatter(regionCode: countryCode)
			}
		}
	}
	
	// If set, a search button appears in the picker inputAccessoryView to present a country search view controller
	public var parentViewController: UIViewController?
	
	// Input Accessory View for the texfield
	public var textFieldInputAccessoryView: UIView?

	
	init() {
		super.init(frame: .zero)
		
		setup()
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		
		setup()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		setup()
	}
	
	deinit {
		parentViewController = nil
	}
	
	override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
		return false
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		leftView?.frame = leftViewRect(forBounds: frame)
		flagButton.imageEdgeInsets = flagButtonEdgeInsets
	}
	
	open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		let width: CGFloat = min(bounds.size.width, leftViewSize.width)
		let height: CGFloat = min(bounds.size.height, leftViewSize.height)
		let rect: CGRect = CGRect(x: 0, y: 0, width: width, height: height - 2)

		return rect
	}
	
	private func setup() {
		setupFlagButton()
		setupPhoneCodeLabel()
		setupLeftView()
		setupCountryPicker()

		autocorrectionType = .no
		addTarget(self, action: #selector(didEditText), for: .editingChanged)
		addTarget(self, action: #selector(displayNumberKeyBoard), for: .touchDown)
		delegate = self
		
		//		for each in countryPicker.countries {
		//			do {
		//				let example = try phoneUtil.getExampleNumber(each.code)
		//				print("textfield.setFlag(with: \"\(each.code!)\")")
		//				print("XCTAssertEqual(textfield.getCountryPhoneCode(), \"+\(example.countryCode.intValue)\")")
		//				print("XCTAssertEqual(textfield.getCountryCode(), \"\(each.code!)\")")
		//				print("textfield.set(phoneNumber: \"+\(example.countryCode.intValue)\(example.nationalNumber!)\")")
		//				print("XCTAssertEqual(textfield.getCountryPhoneCode(), \"+\(example.countryCode.intValue)\")")
		//				print("XCTAssertEqual(textfield.getCountryCode(), \"\(each.code!)\")")
		//			} catch {
		//				print("Error = \(each.code)")
		//			}
		//		}
	}
	
	private func setupFlagButton() {
		flagButton.contentHorizontalAlignment = .fill
		flagButton.contentVerticalAlignment = .fill
		flagButton.imageView?.contentMode = .scaleAspectFit
		flagButton.accessibilityLabel = "flagButton"
		flagButton.addTarget(self, action: #selector(displayCountryKeyboard), for: .touchUpInside)
		flagButton.translatesAutoresizingMaskIntoConstraints = false
		flagButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
	}
	
	private func setupPhoneCodeLabel() {
		phoneCodeLabel.translatesAutoresizingMaskIntoConstraints = false
		phoneCodeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
	}
	
	private func setupLeftView() {
		leftViewMode = UITextFieldViewMode.always
		leftView = UIView()
		leftView?.addSubview(flagButton)
		leftView?.addSubview(phoneCodeLabel)

		let views = ["flag": flagButton, "label": phoneCodeLabel]
		let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[flag]-(0)-[label]|", options: [], metrics: nil, views: views)

		leftView?.addConstraints(horizontalConstraints)
		
		for key in views.keys {
			leftView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[\(key)]|", options: [], metrics: nil, views: views))
		}
	}
	
	private func setupCountryPicker() {
		countryPicker.countryPickerDelegate = self
		countryPicker.showPhoneNumbers = true
		countryPicker.backgroundColor = .white
		countryPicker.setCountry(Locale.current.regionCode!)
	}
	
	@objc private func displayNumberKeyBoard() {
		keyboardType = .numberPad
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
	
	@objc private func displayAlphabeticKeyBoard() {
		showSearchController()
	}
	
	@objc private func resetKeyBoard() {
		keyboardType = .default
		inputView = nil
		inputAccessoryView = nil
		resignFirstResponder()
	}
	
	// - Utils
	
	/// Get the current formatted phone number
	public func getFormattedPhoneNumber() -> String? {
		return phoneNumber
	}
	
	/// Get the current country phone code
	public func getCountryPhoneCode() -> String? {
		return phoneCodeLabel.text
	}
	
	public func getCountryCode() -> String? {
		return countryCode
	}

	/// Get the current raw phone number
	public func getRawPhoneNumber() -> String? {
		var nationalNumber: NSString?
		
		phoneUtil.extractCountryCode(phoneNumber, nationalNumber: &nationalNumber)
		
		return nationalNumber as String?
	}
	
	private func format(string: String) -> String {
		var formattedPhoneNumber: String = string.trimmingCharacters(in: CharacterSet(charactersIn: "+0123456789").inverted)
		
		formattedPhoneNumber = formattedPhoneNumber.replacingOccurrences(of: " ", with: "")
		formattedPhoneNumber = formattedPhoneNumber.replacingOccurrences(of: "-", with: "")
		
		return formattedPhoneNumber
	}

	private func parse(phoneNumber: String) -> NBPhoneNumber? {
		do {
			return try phoneUtil.parse(phoneNumber, defaultRegion: countryCode)
		} catch _ {
			return nil
		}
	}
	
	private func isValidNumber(phoneNumber: String) -> NBPhoneNumber? {
		do {
			let parsedPhoneNumber: NBPhoneNumber = try phoneUtil.parse(phoneNumber, defaultRegion: countryCode)
			
			if phoneUtil.isValidNumber(parsedPhoneNumber) {
				return parsedPhoneNumber
			} else {
				return nil
			}
		} catch _ {
			return nil
		}
	}
	
	@objc private func didEditText() {
		if let phoneCode = phoneCode, let text = text {
			let phoneNumber = phoneCode + text
			var formattedPhoneNumber = format(string: phoneNumber)
			
			if let validNumber = isValidNumber(phoneNumber: formattedPhoneNumber) {
				if let e164PhoneNumber: String = try? phoneUtil.format(validNumber, numberFormat: .E164) {
					self.phoneNumber = e164PhoneNumber
					formattedPhoneNumber = e164PhoneNumber
				} else {
					self.phoneNumber = nil
				}
			} else {
				self.phoneNumber = nil
			}
			
			if var inputString = formatter?.inputString(formattedPhoneNumber) {
				removeCountryCode(in: &inputString)
				self.text = inputString
			}
		}
	}
	
	private func removeCountryCode(in phoneNumber: inout String) {
		if let regionCode = countryCode {
			let countryCode = phoneUtil.getCountryCode(forRegion: regionCode).stringValue

			phoneNumber = phoneNumber.replacingOccurrences(of: "+\(countryCode) ", with: "")
			phoneNumber = phoneNumber.replacingOccurrences(of: "+\(countryCode)", with: "")
		}
	}
	
	/// Set the country image according to country code. Example "FR"
	public func setFlag(for regionCode: String) {
		countryPicker.setCountry(regionCode)
	}
	
	/// Set the placeholder
	public func set(placeholder: String) {
		placeHolder = placeholder
	}
	
	public func set(phoneNumber: String) {
		var formattedPhoneNumber = format(string: phoneNumber)
		
		if let validNumber = isValidNumber(phoneNumber: formattedPhoneNumber) {
			setFlag(for: phoneUtil.getRegionCode(for: validNumber))
			
			if let e164PhoneNumber: String = try? phoneUtil.format(validNumber, numberFormat: .E164) {
				self.phoneNumber = e164PhoneNumber
				formattedPhoneNumber = e164PhoneNumber
			} else {
				self.phoneNumber = nil
			}
		} else {
			self.phoneNumber = nil
		}
		
		if var inputString = formatter?.inputString(formattedPhoneNumber) {
			if let parsedPhoneNumber = parse(phoneNumber: formattedPhoneNumber) {
				inputString = inputString.replacingOccurrences(of: "+\(parsedPhoneNumber.countryCode.stringValue) ", with: "")
				text = inputString.replacingOccurrences(of: "+\(parsedPhoneNumber.countryCode.stringValue)", with: "")
			}
		}
	}
	
	private func showSearchController() {
		if let countries = countryPicker.countries {
			let searchCountryViewController = CTKSearchCountryViewController(countries: countries)
			let navigationViewController = UINavigationController(rootViewController: searchCountryViewController)
			
			searchCountryViewController.delegate = self
			
			parentViewController?.present(navigationViewController, animated: false, completion: nil)
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
		let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
		let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(resetKeyBoard))
		
		doneButton.accessibilityLabel = "doneButton"
		
		if parentViewController != nil {
			let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(displayAlphabeticKeyBoard))
			
			searchButton.accessibilityLabel = "searchButton"
			
			return [searchButton, space, doneButton]
		}
		return [space, doneButton]
	}
	
	// - CountryPickerDelegate

	public func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
		flagButton.setImage(flag, for: .normal)
		self.countryCode = countryCode
		
		if let parsedPhoneNumber = parse(phoneNumber: phoneCode) {
			self.phoneCode = "+\(parsedPhoneNumber.countryCode.stringValue)"
		} else {
			self.phoneCode = phoneCode
		}
		
		if placeHolder == nil {
			if var exampleNumber = try? phoneUtil.format(phoneUtil.getExampleNumber(countryCode), numberFormat: .INTERNATIONAL) {
				removeCountryCode(in: &exampleNumber)
				placeholder = exampleNumber
			}
		}
		
		didEditText()
	}

	// - CTKFlagPhoneNumberDelegate
	
	func didSelect(country: Country) {
		guard let phoneCode = country.phoneCode else { return }
		guard let countryCode = country.code else { return }

		flagButton.setImage(country.flag, for: .normal)
		self.countryCode = countryCode
		
		if let parsedPhoneNumber = parse(phoneNumber: phoneCode) {
			self.phoneCode = "+\(parsedPhoneNumber.countryCode.stringValue)"
		} else {
			self.phoneCode = phoneCode
		}
		
		didEditText()
	}
}
