import UIKit

open class FPNCountryPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

	var countries: [FPNCountry] {
		didSet {
			reloadAllComponents()
		}
	}

	var showPhoneNumbers: Bool

	public var didSelect: ((FPNCountry) -> Void)?

	public init(countries: [FPNCountry], showPhoneNumbers: Bool = true) {
		self.countries = countries
		self.showPhoneNumbers = showPhoneNumbers

		super.init(frame: .zero)

		dataSource = self
		delegate = self
	}

	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - FPNCountry Methods

	open func setCountry(_ code: FPNCountryCode) {
		for index in 0..<countries.count {
			if countries[index].code == code {
				return self.setCountryByRow(row: index)
			}
		}
	}

	private func setCountryByRow(row: Int) {
		self.selectRow(row, inComponent: 0, animated: true)

		if countries.count > 0 {
			let country = countries[row]

			didSelect?(country)
		}
	}

	// MARK: - Picker Methods

	open func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return countries.count
	}

	open func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		var resultView: FPNCountryView

		if view == nil {
			resultView = FPNCountryView()
		} else {
			resultView = view as! FPNCountryView
		}

		resultView.setup(countries[row])

		if !showPhoneNumbers {
			resultView.countryCodeLabel.isHidden = true
		}
		return resultView
	}

	open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if countries.count > 0 {
			let country = countries[row]

			didSelect?(country)
		}
	}
}
