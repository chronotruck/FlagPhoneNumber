//                                                                  _______________________________________________
//                                                                 |                                               | |\
//                                                                 |                                               | ||
//  ____ _                           _                   _         |                                               |,""---:___
// / ___| |__  _ __ ___  _ __   ___ | |_ _ __ _   _  ___| | __     |                                               ||==  | .-.|
// | |  | '_ \| '_// _ \| '_ \ / _ \| __| '_/| | | |/ __| |/ /     |                                               ||==  | '-'-----.
// | |__| | | | | | (_) | | | | (_) | |_| |  | |_| | (__|   <      |_______________________________________________||    |~  |   -(|
// \____|_| |_|_|  \___/|_| |_|\___/ \__|_|   \__,_|\___|_|\_\     |_____________________________/<  _...==...____|    |   | ___   |
//                                                                  \\ .-.  .-. //            \|  \//.-.  .-.\\ --------"-"/.-.\---]
//                                                                  ` ( o )( o )'              '    ( o )( o )`"""""""""==`( o )
//                                                                     '-'  '-'                      '-'  '-'               '-'

//  Created by Aurélien GRIFASI on 07/06/2017.


import Foundation
import libPhoneNumber_iOS

open class CTKFlagPhoneNumberTextField: UITextField, UITextFieldDelegate, CountryPickerDelegate, CTKFlagPhoneNumberDelegate {
	
	// The size of the flag
	public var flagSize = CGSize(width: 32, height: 32) {
		didSet {
			layoutSubviews()
		}
	}
	
	// The edges insets of the flag button
	public var flagButtonEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8) {
		didSet {
			layoutSubviews()
		}
	}

	// If set, a search button appears in the picker inputAccessoryView to present a country search view controller
	public var parentViewController: UIViewController?
	
	// Input Accessory View for the texfield
	public var textFieldInputAccessoryView: UIView?
	
	private var flagButton: UIButton!
	private lazy var countryPicker: CountryPicker = CountryPicker()
	private lazy var phoneUtil: NBPhoneNumberUtil = NBPhoneNumberUtil()
	private var formatter: NBAsYouTypeFormatter?
	
	private var phoneCode: String?
	private var phoneNumber: String?
	
	private var countryCode: String? {
		didSet {
			if let countryCode = countryCode {
				formatter = NBAsYouTypeFormatter(regionCode: countryCode)
			}
		}
	}
	
	private var leftViewSize: CGSize {
		return CGSize(
			width: flagSize.width + flagButtonEdgeInsets.left + flagButtonEdgeInsets.right,
			height: flagSize.height + flagButtonEdgeInsets.top + flagButtonEdgeInsets.bottom)
	}
	
	open override var intrinsicContentSize: CGSize {
		var intrinsicContentSize = super.intrinsicContentSize
		let leftViewHeight = leftViewSize.height
		
		intrinsicContentSize.height = max(intrinsicContentSize.height, leftViewHeight)
		return intrinsicContentSize
	}

	
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
	
	override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
		return false
	}
	
	private func setup() {
		borderStyle = .roundedRect
		leftViewMode = UITextFieldViewMode.always
		autocorrectionType = .no
		addTarget(self, action: #selector(didEditText), for: .editingChanged)
		delegate = self
		
		countryPicker.countryPickerDelegate = self
		countryPicker.showPhoneNumbers = true
		countryPicker.backgroundColor = .white
		
		addTarget(self, action: #selector(displayNumberKeyBoard), for: .touchDown)
		
		leftView = UIView()
		
		flagButton = UIButton()
		flagButton.contentHorizontalAlignment = .fill
		flagButton.contentVerticalAlignment = .fill
		flagButton.imageView?.contentMode = .scaleAspectFit
		flagButton.accessibilityLabel = "flagButton"
		flagButton.addTarget(self, action: #selector(displayCountryKeyboard), for: .touchUpInside)
		
		leftView?.addSubview(flagButton)
		
		countryPicker.setCountry(Locale.current.regionCode!)
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		leftView?.frame = leftViewRect(forBounds: frame)
		flagButton.frame = CGRect(x: flagButtonEdgeInsets.left, y: flagButtonEdgeInsets.top, width: flagSize.width, height: flagSize.height)
	}
	
	open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		let width = min(bounds.size.width, leftViewSize.width)
		let height = min(bounds.size.height, leftViewSize.height)
		let rect = CGRect(x: 0, y: bounds.size.height / 2 - height / 2, width: width, height: height)
		
		return rect
	}
	
	open override func textRect(forBounds bounds: CGRect) -> CGRect {
		var textRect = super.textRect(forBounds: bounds)
		let spaceBetweenLeftViewAndText = textRect.minX - leftViewRect(forBounds: bounds).maxX
		
		if spaceBetweenLeftViewAndText > 0 {
			textRect.origin.x -= spaceBetweenLeftViewAndText
			textRect.size.width += spaceBetweenLeftViewAndText
		}
		return textRect
	}
	
	open override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return textRect(forBounds: bounds)
	}
	
	open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		return textRect(forBounds:bounds)
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
		return phoneCode
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
		formatText()
		set(phoneNumber: text!)
	}
	
	private func formatText() {
		text = text?.trimmingCharacters(in: CharacterSet(charactersIn: "+0123456789").inverted)
		text = text?.replacingOccurrences(of: " ", with: "")
		text = text?.replacingOccurrences(of: "-", with: "")
		text = formatter?.inputString(text)
	}
	
	public func set(phoneNumber: String) {
		do {
			let parsedPhoneNumber: NBPhoneNumber = try phoneUtil.parse(phoneNumber, defaultRegion: countryCode)
			
			if phoneUtil.isValidNumber(parsedPhoneNumber) {
				do {
					let e164PhoneNumber: String = try phoneUtil.format(parsedPhoneNumber, numberFormat: .E164)
					
					setFlag(with: phoneUtil.getRegionCode(for: parsedPhoneNumber))
					
					self.phoneNumber = e164PhoneNumber
					text = self.phoneNumber
					formatText()
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
	
	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if string == "" && text == phoneCode {
			return false
		}
		return true
	}
	
	// - CountryPickerDelegate

	public func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
		self.phoneCode = phoneCode
		self.countryCode = countryCode
		
		flagButton.setImage(flag, for: .normal)
		text = phoneCode
		
		sendActions(for: .editingChanged)
	}

	// - CTKFlagPhoneNumberDelegate
	
	func didSelect(country: Country) {
		self.phoneCode = country.phoneCode
		self.countryCode = country.code
		
		flagButton.setImage(country.flag, for: .normal)
		text = phoneCode
		
		sendActions(for: .editingChanged)
	}
}
