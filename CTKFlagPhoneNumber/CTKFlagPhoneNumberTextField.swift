//                                                                  _______________________________________________
//                                                                 |                                               | |\
//                                                                 |                                               | ||
//  ____ _                           _                   _         |                                               |,""---:___
// / ___| |__  _ __ ___  _ __   ___ | |_ _ _  _   _  ___| | __     |                                               ||==  | .-.|
// | |  | '_ \| '_// _ \| '_ \ / _ \| __| '_/| | | |/ __| |/ /     |                                               ||==  | '-'-----.
// | |__| | | | | | (_) | | | | (_) | |_| |  | |_| | (__|   <      |_______________________________________________||    |~  |   -(|
// \____|_| |_|_|  \___/|_| |_|\___/ \__|_|   \__,_|\___|_|\_\     |_____________________________/<  _...==...____|    |   | ___ |
//                                                                  \\ .-.  .-. //            \|  \//.-.  .-.\\ --------"-"/.-.\_]
//                                                                  ` ( o )( o )'              '    ( o )( o )`"""""""""==`( o )
//                                                                     '-'  '-'                      '-'  '-'               '-'

//  Created by Aurélien GRIFASI on 07/06/2017.


import Foundation
import libPhoneNumber_iOS

extension Bundle {
	static public func CTKFrameworkBundle() -> Bundle {
		let bundle = Bundle(for: CTKFlagPhoneNumberTextField.self)
		if let path = bundle.path(forResource: "CTKFlagPhoneNumber", ofType: "bundle") {
			return Bundle(path: path)!
		}
		else {
			return bundle
		}
	}
}

public class CTKFlagPhoneNumberTextField: UITextField, UITextFieldDelegate, MRCountryPickerDelegate {

    private static let FlagSize = CGSize(width: 32, height: 32)
	
    public var flagButtonEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8) {
        didSet {
            self.layoutSubviews()
        }
    }
	private var flagButton: UIButton!
	private lazy var countryPicker: MRCountryPicker = MRCountryPicker()
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
	
	override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
		return false
	}
	
	private func setup() {
		borderStyle = .roundedRect
		leftViewMode = UITextFieldViewMode.always
		keyboardType = .numberPad
		inputAccessoryView = getToolBar(target: self, selector: #selector(resetKeyBoard))
		addTarget(self, action: #selector(update), for: .editingChanged)
		delegate = self
		
		countryPicker.countryPickerDelegate = self
		countryPicker.showPhoneNumbers = true
		
		addTarget(self, action: #selector(displayNumberKeyBoard), for: .touchDown)
		
		leftView = UIView()
		
		flagButton = UIButton()
		flagButton.accessibilityLabel = "flagButton"
		flagButton.addTarget(self, action: #selector(displayCountryKeyboard), for: .touchUpInside)
		
		leftView?.addSubview(flagButton)
		
		countryPicker.setCountry(Locale.current.regionCode!)
	}
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        leftView?.frame = leftViewRect(forBounds: self.frame)
        flagButton.frame = CGRect(x: flagButtonEdgeInsets.left, y: flagButtonEdgeInsets.top, width: CTKFlagPhoneNumberTextField.FlagSize.width, height: CTKFlagPhoneNumberTextField.FlagSize.height)
    }
    
    public override var intrinsicContentSize: CGSize {
        var intrinsicContentSize = super.intrinsicContentSize
        let leftViewHeight = leftViewSize.height
        intrinsicContentSize.height = max(intrinsicContentSize.height, leftViewHeight)
        return intrinsicContentSize
    }
    
    private var leftViewSize: CGSize {
        return CGSize(
            width: CTKFlagPhoneNumberTextField.FlagSize.width + flagButtonEdgeInsets.left + flagButtonEdgeInsets.right,
            height: CTKFlagPhoneNumberTextField.FlagSize.height + flagButtonEdgeInsets.top + flagButtonEdgeInsets.bottom)
    }
    
    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let width = min(bounds.size.width, leftViewSize.width)
        let height = min(bounds.size.height, leftViewSize.height)
        let rect = CGRect(x: 0, y: bounds.size.height / 2 - height / 2, width: width, height: height)
        return rect
    }
	
	@objc private func displayNumberKeyBoard() {
		if inputView != nil {
			inputView = nil
			tintColor = .gray
			reloadInputViews()
		}
	}
	
	@objc private func displayCountryKeyboard() {
		if inputView == nil {
			inputView = countryPicker
			tintColor = .clear
			reloadInputViews()
		}
		becomeFirstResponder()
	}
	
	@objc private func resetKeyBoard() {
		inputView = nil
		resignFirstResponder()
	}
	
	public func getPhoneNumber() -> String? {
		return phoneNumber
	}
	
	public func setFlag(with countryCode: String) {
		countryPicker.setCountry(countryCode)
	}
	
	@objc private func update() {
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
					
					self.phoneNumber = e164PhoneNumber
					setFlag(with: phoneUtil.getRegionCode(for: parsedPhoneNumber))

					text = self.phoneNumber
					sendActions(for: .editingChanged)
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
	
	// UITextFieldDelegate
	
	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if string == "" && text == phoneCode {
			return false
		}
		return true
	}
	
	public func textFieldDidEndEditing(_ textField: UITextField) {
		set(phoneNumber: textField.text!)
	}
	

	// MRCountryPickerDelegate
	
	public func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
		self.phoneCode = phoneCode
		self.countryCode = countryCode
	
		flagButton.setImage(flag, for: .normal)
		text = phoneCode
		sendActions(for: .editingChanged)
	}
}
