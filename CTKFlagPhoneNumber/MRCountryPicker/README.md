# MRCountryPicker

[![CI Status](http://img.shields.io/travis/xtrinch/MRCountryPicker.svg?style=flat)](https://travis-ci.org/xtrinch/MRCountryPicker)
[![Version](https://img.shields.io/cocoapods/v/MRCountryPicker.svg?style=flat)](http://cocoapods.org/pods/MRCountryPicker)
[![License](https://img.shields.io/cocoapods/l/MRCountryPicker.svg?style=flat)](http://cocoapods.org/pods/MRCountryPicker)
[![Platform](https://img.shields.io/cocoapods/p/MRCountryPicker.svg?style=flat)](http://cocoapods.org/pods/MRCountryPicker)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Versions below 0.0.4 are Swift 2.2 compatible, Version 0.0.5+ is Swift 3 compatible.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. 

![screen shot 2016-06-11 at 13 00 05](https://cloud.githubusercontent.com/assets/7256491/15984684/7930c73e-2fd4-11e6-83b8-91d522674a0c.png)

## Usage

Make your UIPickerView a class of MRCountryPicker, set its countryPickerDelegate and implement its countryPhoneCodePicker method.

See the following example:

```
class ViewController: UIViewController, MRCountryPickerDelegate {

    @IBOutlet weak var countryPicker: MRCountryPicker!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var phoneCode: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPicker.countryPickerDelegate = self
        countryPicker.showPhoneNumbers = true

        // set country by its code
        countryPicker.setCountry("SI")

        // optionally set custom locale; defaults to system's locale
        countryPicker.setLocale("sl_SI")

        // set country by its name
        countryPicker.setCountryByName("Canada")
    }
    
    // a picker item was selected
    func countryPhoneCodePicker(picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        self.countryName.text = name
        self.countryCode.text = countryCode
        self.phoneCode.text = phoneCode
        self.countryFlag.image = flag
    }

}
```

## Installation

MRCountryPicker is available through Cocoapods and Carthage.

#### [CocoaPods](http://cocoapods.org):
Add the following line to your Podfile:

```ruby
pod 'MRCountryPicker', '~> 0.0.7'
```

#### [Carthage](https://github.com/Carthage/Carthage):
Add the following line to your Cartfile:

```ruby
github "xTrinch/MRCountryPicker" ~> 0.0.7
```

## Author

xtrinch, mojca.rojko@gmail.com 

Made with a little help from my friends over at:  
https://github.com/marmelroy/PhoneNumberKit  
https://github.com/Keyflow/CountryPicker-iOS-Swift  
https://github.com/nicklockwood/CountryPicker

## License

MRCountryPicker is available under the MIT license. See the LICENSE file for more info.
