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
	public var flagButtonEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
		didSet {
			layoutSubviews()
		}
	}
	
	private var leftViewSize: CGSize {
		let width = flagSize.width + flagButtonEdgeInsets.left + flagButtonEdgeInsets.right + phoneCodeLabel.frame.width
		let height = flagSize.height + flagButtonEdgeInsets.top + flagButtonEdgeInsets.bottom

		return CGSize(width: width, height: height)
	}
	
//	open override var intrinsicContentSize: CGSize {
//		var intrinsicContentSize = super.intrinsicContentSize
//		let leftViewHeight = leftViewSize.height
//
//		intrinsicContentSize.height = max(intrinsicContentSize.height, leftViewHeight)
//		return intrinsicContentSize
//	}
//
	public var flagButton: UIButton = UIButton()
	public var phoneCodeLabel: UILabel = UILabel()
	private lazy var countryPicker: CountryPicker = CountryPicker()
	private lazy var phoneUtil: NBPhoneNumberUtil = NBPhoneNumberUtil()
	
	private var formatter: NBAsYouTypeFormatter?
	
	private var phoneNumber: String?
	private var phoneCode: String? {
		didSet {
			phoneCodeLabel.text = phoneCode
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
		let frame1 = CGRect(x: flagButtonEdgeInsets.left, y: flagButtonEdgeInsets.top, width: flagSize.width, height: flagSize.height)
		
		flagButton.frame = frame1
		
		leftView?.updateConstraints()
		leftView?.updateConstraintsIfNeeded()
	}
	
	open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		let width = min(bounds.size.width, leftViewSize.width)
		let height = min(bounds.size.height, leftViewSize.height)
		let rect = CGRect(x: 0, y: bounds.size.height / 2 - height / 2, width: width, height: height)
		
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

	
	
//	open override func textRect(forBounds bounds: CGRect) -> CGRect {
//		var textRect = super.textRect(forBounds: bounds)
//		let spaceBetweenLeftViewAndText = textRect.minX - leftViewRect(forBounds: bounds).maxX
//		
//		if spaceBetweenLeftViewAndText > 0 {
//			textRect.origin.x -= spaceBetweenLeftViewAndText
//			textRect.size.width += spaceBetweenLeftViewAndText
//		}
//		return textRect
//	}
//	
//	open override func editingRect(forBounds bounds: CGRect) -> CGRect {
//		return textRect(forBounds: bounds)
//	}
//	
//	open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//		return textRect(forBounds:bounds)
//	}
	
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

	/// Get the current raw phone number
	public func getRawPhoneNumber() -> String? {
		var nationalNumber: NSString?
		
		phoneUtil.extractCountryCode(phoneNumber, nationalNumber: &nationalNumber)
		
		return nationalNumber as String?
	}

	/// Set the country image according to country code
	public func setFlag(with countryCode: String) {
		countryPicker.setCountry(countryCode)
	}
	
	@objc private func didEditText() {
		if let phoneNumber = text, let formattedPhoneNumber = format(phoneNumber: phoneNumber) {
			set(phoneNumber: formattedPhoneNumber)
		}
	}
	
	private func format(phoneNumber: String) -> String? {
		var formattedPhoneNumber: String?
		
		if let phoneCode = phoneCode {
			formattedPhoneNumber = phoneCode + phoneNumber.replacingOccurrences(of: phoneCode, with: "")
			formattedPhoneNumber = formattedPhoneNumber?.trimmingCharacters(in: CharacterSet(charactersIn: "+0123456789").inverted)
			formattedPhoneNumber = formattedPhoneNumber?.replacingOccurrences(of: " ", with: "")
			formattedPhoneNumber = formattedPhoneNumber?.replacingOccurrences(of: "-", with: "")
			formattedPhoneNumber = formatter!.inputString(formattedPhoneNumber)
			
			text = formattedPhoneNumber?.replacingOccurrences(of: phoneCode, with: "")
		}
		return formattedPhoneNumber
	}
	
	public func set(phoneNumber: String) {
		do {
			let parsedPhoneNumber: NBPhoneNumber = try phoneUtil.parse(phoneNumber, defaultRegion: countryCode)
			
			if phoneUtil.isValidNumber(parsedPhoneNumber) {
				do {
					let e164PhoneNumber: String = try phoneUtil.format(parsedPhoneNumber, numberFormat: .E164)
					
					setFlag(with: phoneUtil.getRegionCode(for: parsedPhoneNumber))
					
					self.phoneNumber = e164PhoneNumber
					_ = format(phoneNumber: e164PhoneNumber)
				} catch _ {
					self.phoneNumber = nil
				}
			} else {
				self.phoneNumber = nil
			}
		} catch _ {
			self.phoneNumber = nil
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

	// - UITextFieldDelegate
	
//	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//		if string == "" && text == phoneCode {
//			return false
//		}
//		return true
//	}
	
	// - CountryPickerDelegate

	public func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
		self.phoneCode = phoneCode
		self.countryCode = countryCode
		
		flagButton.setImage(flag, for: .normal)
		
		//		sendActions(for: .editingChanged)
		
		phoneCodeLabel.sizeToFit()
		layoutSubviews()
	}

	// - CTKFlagPhoneNumberDelegate
	
	func didSelect(country: Country) {
		phoneCode = country.phoneCode
		countryCode = country.code

		flagButton.setImage(country.flag, for: .normal)
		
		sendActions(for: .editingChanged)
		
		phoneCodeLabel.sizeToFit()
		layoutSubviews()
	}
}
