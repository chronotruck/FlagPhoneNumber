import UIKit

open class FPNCountryPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

	open var repository: FPNCountryRepository?
	open var showPhoneNumbers: Bool
	open var didSelect: ((FPNCountry) -> Void)?

	public init(showPhoneNumbers: Bool = true) {
		self.showPhoneNumbers = showPhoneNumbers

		super.init(frame: .zero)

		dataSource = self
		delegate = self
	}

	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	open func setup(repository: FPNCountryRepository) {
		self.repository = repository

		reloadAllComponents()
	}

	// MARK: - FPNCountry Methods

	open func setCountry(_ code: FPNCountryCode) {
		guard let countries = repository?.countries else { return }

		for (index, country) in countries.enumerated() {
			if country.code == code {
				selectRow(index, inComponent: 0, animated: true)
				didSelect?(country)
			}
		}
	}

	// MARK: - Picker Methods

	open func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return repository?.countries.count ?? 0
	}

	open func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		var resultView: FPNCountryView
		let country = repository!.countries[row]

		if view == nil {
			resultView = FPNCountryView()
		} else {
			resultView = view as! FPNCountryView
		}

		resultView.setup(country)

		if !showPhoneNumbers {
			resultView.countryCodeLabel.isHidden = true
		}
		return resultView
	}

	open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		guard let countries = repository?.countries else { return }

		let country = countries[row]

		didSelect?(country)
	}
}
