//
//  CTKFlagPhoneNumberTextField.swift
//  CTKFlagPhoneNumber
//
//  Created by Chronotruck on 01/06/2017.
//

import Foundation
import libPhoneNumber_iOS

public enum FPNFormat {
	case E164, International, National, RFC3966
}

public enum PhoneNumberFormat {
	case E164, International, National
}

open class CTKFlagPhoneNumberTextField: UITextField, UITextFieldDelegate, CountryPickerDelegate, CTKFlagPhoneNumberDelegate {


	public var flagPhoneNumberDelegate: CTKFlagPhoneNumberTextFieldDelegate?

	/// The size of the flag
	public var flagSize: CGSize = CGSize(width: 32, height: 32) {
		didSet {
			layoutSubviews()
		}
	}
	
	/// The edges insets of the flag button
	public var flagButtonEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5) {
		didSet {
			layoutSubviews()
		}
	}
	
	/// The size of the leftView
	private var leftViewSize: CGSize {
		let width = flagSize.width + flagButtonEdgeInsets.left + flagButtonEdgeInsets.right + phoneCodeTextField.frame.width
		let height = bounds.height

		return CGSize(width: width, height: height)
	}

	private var phoneCodeTextField: UITextField = UITextField()
	private lazy var countryPicker: CountryPicker = CountryPicker()
	private lazy var phoneUtil: NBPhoneNumberUtil = NBPhoneNumberUtil()
	private var nbPhoneNumber: NBPhoneNumber?
	private var formatter: NBAsYouTypeFormatter?
	
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

	public var phoneNumberFormat: PhoneNumberFormat = .International

	/// Present in the placeholder an example of a phone number according to the selected country code.
	/// If false, you can set your own placeholder. Set to true by default.
	public var hasPhoneNumberExample: Bool = true {
		didSet {
			if hasPhoneNumberExample == false {
				placeholder = nil
			}
			updatePlaceholder()
		}
	}

	var selectedCountry: Country? {
		didSet {
			updateUI()
		}
	}


	/// If set, a search button appears in the picker inputAccessoryView to present a country search view controller
	public var parentViewController: UIViewController?
	
	/// Input Accessory View for the texfield
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
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		leftView?.frame = leftViewRect(forBounds: frame)
		flagButton.imageEdgeInsets = flagButtonEdgeInsets
	}
	
	open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		let width: CGFloat = min(bounds.size.width, leftViewSize.width)
		let height: CGFloat = min(bounds.size.height, leftViewSize.height)
		let rect: CGRect = CGRect(x: 0, y: 0, width: width, height: height)

		return rect
	}
	
	private func setup() {
		setupFlagButton()
		setupPhoneCodeTextField()
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
		flagButton.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
	}
	
	private func setupPhoneCodeTextField() {
		phoneCodeTextField.isUserInteractionEnabled = false
		phoneCodeTextField.translatesAutoresizingMaskIntoConstraints = false
		phoneCodeTextField.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
	}
	
	private func setupLeftView() {
		leftViewMode = UITextFieldViewMode.always
		leftView = UIView()
		leftView?.addSubview(flagButton)
		leftView?.addSubview(phoneCodeTextField)

		let views = ["flag": flagButton, "textField": phoneCodeTextField]
		let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[flag]-(0)-[textField]|", options: [], metrics: nil, views: views)

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
	
	// - Public

	/// Set the country image according to country code. Example "FR"
	public func setFlag(for regionCode: String) {
		countryPicker.setCountry(regionCode)
	}

	/// Get the current formatted phone number
	public func getFormattedPhoneNumber(format: FPNFormat) -> String? {
		return try? phoneUtil.format(nbPhoneNumber, numberFormat: convert(format: format))
	}

	/// Get the current raw phone number
	public func getRawPhoneNumber() -> String? {
		let phoneNumber = getFormattedPhoneNumber(format: .E164)
		var nationalNumber: NSString?

		phoneUtil.extractCountryCode(phoneNumber, nationalNumber: &nationalNumber)

		return nationalNumber as String?
	}

	/// Set directly the phone number. e.g "+33612345678"
	public func set(phoneNumber: String) {
		let cleanedPhoneNumber = format(string: phoneNumber)

		if isValidNumber(phoneNumber: cleanedPhoneNumber) {
			let format = convert(toFPNFormat: phoneNumberFormat)

			setFlag(for: phoneUtil.getRegionCode(for: nbPhoneNumber!))

			if let formattedPhoneNumber: String = getFormattedPhoneNumber(format: format) {
				if var inputString = formatter?.inputString(formattedPhoneNumber) {
					removeCountryCode(in: &inputString)
					text = inputString
				}
			}
		} else {
			if var inputString = formatter?.inputString(cleanedPhoneNumber) {
				removeCountryCode(in: &inputString)
				text = inputString
			}
		}
	}

	// Private

	@objc private func didEditText() {
		if let phoneCode = selectedCountry?.phoneCode, let text = text {
			let cleanedPhoneNumber = format(string: phoneCode + text)

			if isValidNumber(phoneNumber: cleanedPhoneNumber) {
				let format = convert(toFPNFormat: phoneNumberFormat)

				if let formattedPhoneNumber: String = getFormattedPhoneNumber(format: format) {
					if var inputString = formatter?.inputString(formattedPhoneNumber) {
						removeCountryCode(in: &inputString)
						self.text = inputString
					}
				}
			} else {
				if var inputString = formatter?.inputString(cleanedPhoneNumber) {
					removeCountryCode(in: &inputString)
					self.text = inputString
				}
			}
		}
	}

	private func convert(format: FPNFormat) -> NBEPhoneNumberFormat {
		switch format {
		case .E164:
			return NBEPhoneNumberFormat.E164
		case .International:
			return NBEPhoneNumberFormat.INTERNATIONAL
		case .National:
			return NBEPhoneNumberFormat.NATIONAL
		case .RFC3966:
			return NBEPhoneNumberFormat.RFC3966
		}
	}

	private func convert(toFPNFormat format: PhoneNumberFormat) -> FPNFormat {
		switch format {
		case .E164:
			return FPNFormat.E164
		case .International:
			return FPNFormat.International
		case .National:
			return FPNFormat.National
		}
	}

	private func convert(toNBEPhoneNumberFormat format: PhoneNumberFormat) -> NBEPhoneNumberFormat {
		switch format {
		case .E164:
			return NBEPhoneNumberFormat.E164
		case .International:
			return NBEPhoneNumberFormat.INTERNATIONAL
		case .National:
			return NBEPhoneNumberFormat.NATIONAL
		}
	}

	private func updateUI() {
		if let countryCode = selectedCountry?.code {
			formatter = NBAsYouTypeFormatter(regionCode: countryCode)
		}

		flagButton.setImage(selectedCountry?.flag, for: .normal)

		if let phoneCode = selectedCountry?.phoneCode {
			if let parsedPhoneNumber = parse(phoneNumber: phoneCode) {
				phoneCodeTextField.text = "+\(parsedPhoneNumber.countryCode.stringValue)"
			} else {
				phoneCodeTextField.text = phoneCode
			}
			phoneCodeTextField.sizeToFit()
			layoutSubviews()
		}

		if hasPhoneNumberExample == true {
			updatePlaceholder()
		}
		didEditText()
	}

	private func format(string: String) -> String {
		var formattedPhoneNumber: String = string.trimmingCharacters(in: CharacterSet(charactersIn: "+0123456789").inverted)
		
		formattedPhoneNumber = formattedPhoneNumber.replacingOccurrences(of: " ", with: "")
		formattedPhoneNumber = formattedPhoneNumber.replacingOccurrences(of: "-", with: "")
		
		return formattedPhoneNumber
	}

	private func parse(phoneNumber: String) -> NBPhoneNumber? {
		guard let countryCode = selectedCountry?.code else { return nil }

		do {
			return try phoneUtil.parse(phoneNumber, defaultRegion: countryCode)
		} catch _ {
			return nil
		}
	}
	
	private func isValidNumber(phoneNumber: String) -> Bool {
		guard let countryCode = selectedCountry?.code else { return false }

		do {
			let parsedPhoneNumber: NBPhoneNumber = try phoneUtil.parse(phoneNumber, defaultRegion: countryCode)
			let isValid = phoneUtil.isValidNumber(parsedPhoneNumber)

			nbPhoneNumber = isValid ? parsedPhoneNumber : nil
			flagPhoneNumberDelegate?.didValidatePhoneNumber(textField: self, isValid: isValid)
		} catch _ {
			nbPhoneNumber = nil
			flagPhoneNumberDelegate?.didValidatePhoneNumber(textField: self, isValid: false)
		}
		return nbPhoneNumber != nil
	}
	
	private func removeCountryCode(in phoneNumber: inout String) {
		if let regionCode = selectedCountry?.code {
			let countryCode = phoneUtil.getCountryCode(forRegion: regionCode).stringValue

			phoneNumber = phoneNumber.replacingOccurrences(of: "+\(countryCode) ", with: "")
			phoneNumber = phoneNumber.replacingOccurrences(of: "+\(countryCode)", with: "")
		}
	}

	private func showSearchController() {
		if let countries = countryPicker.countries {
			let searchCountryViewController = CTKSearchCountryViewController(countries: countries)
			let navigationViewController = UINavigationController(rootViewController: searchCountryViewController)
			
			searchCountryViewController.delegate = self
			
			parentViewController?.present(navigationViewController, animated: true, completion: nil)
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

	private func updatePlaceholder() {
		if let countryCode = selectedCountry?.code {
			do {
				let example = try phoneUtil.getExampleNumber(countryCode)
				let format = convert(toNBEPhoneNumberFormat: phoneNumberFormat)
				var exampleString = try phoneUtil.format(example, numberFormat: format)

				removeCountryCode(in: &exampleString)
				placeholder = exampleString
			} catch _ {
				placeholder = nil
			}
		} else {
			placeholder = nil
		}
	}
	
	// - CountryPickerDelegate

	func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountry country: Country) {
		selectedCountry = country

		if let name = country.name, let dialCode = country.phoneCode, let code = country.code {
			flagPhoneNumberDelegate?.didSelectCountry(name: name, dialCode: dialCode, code: code)
		}
	}

	// - CTKFlagPhoneNumberTextFieldDelegate
	
	internal func didSelect(country: Country) {
		setFlag(for: country.code!)
	}
}
