import UIKit

@objc public protocol CountryPickerDelegate {
	func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage)
}

open class CountryPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
	
	var countries: [Country]!
	open var selectedLocale: Locale?
	open weak var countryPickerDelegate: CountryPickerDelegate?
	open var showPhoneNumbers: Bool = true
		
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setup()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		setup()
	}
	
	func setup() {
		if let code = Locale.preferredLanguages.first {
			self.selectedLocale = Locale(identifier: code)
		}
		
		countries = countryNamesByCode()
		
		super.dataSource = self
		super.delegate = self
	}
	
	// MARK: - Locale Methods
	
	open func setLocale(_ locale: String) {
		self.selectedLocale = Locale(identifier: locale)
	}
	
	// MARK: - Country Methods
	
	open func setCountry(_ code: String) {
		for index in 0..<countries.count {
			if countries[index].code == code {
				return self.setCountryByRow(row: index)
			}
		}
	}
	
	open func setCountryByPhoneCode(_ phoneCode: String) {
		for index in 0..<countries.count {
			if countries[index].phoneCode == phoneCode {
				return self.setCountryByRow(row: index)
			}
		}
	}
	
	open func setCountryByName(_ name: String) {
		for index in 0..<countries.count {
			if countries[index].name == name {
				return self.setCountryByRow(row: index)
			}
		}
	}
	
	func setCountryByRow(row: Int) {
		self.selectRow(row, inComponent: 0, animated: true)
		let country = countries[row]
		if let countryPickerDelegate = countryPickerDelegate {
			countryPickerDelegate.countryPhoneCodePicker(self, didSelectCountryWithName: country.name!, countryCode: country.code!, phoneCode: country.phoneCode!, flag: country.flag!)
		}
	}
	
	// Populates the metadata from the included json file resource
	
	private func countryNamesByCode() -> [Country] {
		let bundle: Bundle = Bundle.CTKFlagPhoneNumber()
		let resource: String = "countryCodes"
		let jsonPath = bundle.path(forResource: resource, ofType: "json")

		assert(jsonPath != nil, "Resource file is not found in the Bundle")

		let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath!))
		
		assert(jsonPath != nil, "Resource file is not found")
		
		var countries = [Country]()
		
		do {
			if let jsonObjects = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray {
				
				for jsonObject in jsonObjects {
					
					guard let countryObj = jsonObject as? NSDictionary else {
						return countries
					}
					
					guard let code = countryObj["code"] as? String, let phoneCode = countryObj["dial_code"] as? String, let name = countryObj["name"] as? String else {
						return countries
					}
					
					if let locale = self.selectedLocale {
						let country = Country(code: code, name: locale.localizedString(forRegionCode: code), phoneCode: phoneCode)

						countries.append(country)
					} else {
						let country = Country(code: code, name: name, phoneCode: phoneCode)
						
						countries.append(country)
					}
				}
				
			}
		} catch let error {
			assertionFailure(error.localizedDescription)
		}
		return countries.sorted(by: { $0.name! < $1.name! })
	}
		
	// MARK: - Picker Methods
	
	open func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return countries.count
	}
	
	open func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		var resultView: CountryView
		
		if view == nil {
			resultView = CountryView()
		} else {
			resultView = view as! CountryView
		}
		
		resultView.setup(countries[row])
		
		if !showPhoneNumbers {
			resultView.countryCodeLabel.isHidden = true
		}
		return resultView
	}
	
	open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		let country = countries[row]
		
		if let countryPickerDelegate = countryPickerDelegate {
			countryPickerDelegate.countryPhoneCodePicker(self, didSelectCountryWithName: country.name!, countryCode: country.code!, phoneCode: country.phoneCode!, flag: country.flag!)
		}
	}
}
