//
//  FPNCountryRepository.swift
//  FlagPhoneNumber
//
//  Created by Aurelien on 21/11/2019.
//

import Foundation

open class FPNCountryRepository {

	open var locale: Locale
	open var countries: [FPNCountry] = []

	public init(locale: Locale = Locale.current) {
		self.locale = locale
		
		countries = getAllCountries()
	}

	// Populates the metadata from the included json file resource
	private func getAllCountries() -> [FPNCountry] {
		let bundle: Bundle = Bundle.FlagPhoneNumber()
		let resource: String = "countryCodes"
		let jsonPath = bundle.path(forResource: resource, ofType: "json")

		assert(jsonPath != nil, "Resource file is not found in the Bundle")

		let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath!))

		assert(jsonPath != nil, "Resource file is not found")

		var countries = [FPNCountry]()

		do {
			if let jsonObjects = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray {

				for jsonObject in jsonObjects {
					guard let countryObj = jsonObject as? NSDictionary else { return countries }
					guard let code = countryObj["code"] as? String, let phoneCode = countryObj["dial_code"] as? String, let name = countryObj["name"] as? String else { return countries }


					let country = FPNCountry(code: code, name: locale.localizedString(forRegionCode: code) ?? name, phoneCode: phoneCode)

					countries.append(country)
				}

			}
		} catch let error {
			assertionFailure(error.localizedDescription)
		}
		return countries.sorted(by: { $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending })
	}

	private func getAllCountries(excluding countryCodes: [FPNCountryCode]) -> [FPNCountry] {
		var allCountries = getAllCountries()

		for countryCode in countryCodes {
			allCountries.removeAll(where: { (country: FPNCountry) -> Bool in
				return country.code == countryCode
			})
		}
		return allCountries
	}

	private func getAllCountries(equalTo countryCodes: [FPNCountryCode]) -> [FPNCountry] {
		let allCountries = getAllCountries()
		var countries = [FPNCountry]()

		for countryCode in countryCodes {
			for country in allCountries {
				if country.code == countryCode {
					countries.append(country)
				}
			}
		}
		return countries
	}

	open func setup(with countryCodes: [FPNCountryCode]) {
		countries = getAllCountries(equalTo: countryCodes)
	}

	open func setup(without countryCodes: [FPNCountryCode]) {
		countries = getAllCountries(excluding: countryCodes)
	}

}
