//
//  FPNUtils.swift
//  FlagPhoneNumber
//
//  Created by Aurelien on 03/12/2019.
//

import Foundation

open class FPNUtils {

	open class func getCurrentCountry() -> FPNCountry? {
		let repository = FPNCountryRepository()
		let countries = repository.countries

		if let regionCode = Locale.current.regionCode, let countryCode = FPNCountryCode(rawValue: regionCode) {
			return countries.first(where: { $0.code == countryCode })
		}
		return nil
	}
}
