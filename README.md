# CTKFlagPhoneNumber

CTKFlagPhoneNumber is a phone number textfield with a fancy country code picker.   

[![CI Status](http://img.shields.io/travis/grifas/CTKFlagPhoneNumber.svg?style=flat)](https://travis-ci.org/chronotruck/CTKFlagPhoneNumber)
[![Version](https://img.shields.io/cocoapods/v/CTKFlagPhoneNumber.svg?style=flat)](http://cocoapods.org/pods/CTKFlagPhoneNumber)
[![License](https://img.shields.io/cocoapods/l/CTKFlagPhoneNumber.svg?style=flat)](http://cocoapods.org/pods/CTKFlagPhoneNumber)
[![Platform](https://img.shields.io/cocoapods/p/CTKFlagPhoneNumber.svg?style=flat)](http://cocoapods.org/pods/CTKFlagPhoneNumber)
[![Language](https://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)

## Screenshot
![sample](Screenshot/screenshot_1.PNG)
![sample](Screenshot/screenshot_2.PNG)
![sample](Screenshot/screenshot_3.PNG)

## Localization 🌍

Country names are displayed according to the phone language

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

CTKFlagPhoneNumber is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CTKFlagPhoneNumber"
```

## Usage

You can instance it in storyboards or .xibs.

Programmatically:
```swift
phoneNumberTextField = CTKFlagPhoneNumberTextField(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 16, height: 50))

// Set the parent view controller to enable the search
phoneNumberTextField.parentViewController = self

// You can change the choosen flag
phoneNumberTextField.setFlag(with: "FR")

// You can change the phone number, that will update automatically the flag image
phoneNumberTextField.set(phoneNumber: "0600000001")

// You can also get the phone number to E164 format, the country phone code and the raw phone number
print(phoneNumberTextField.getFormattedPhoneNumber()) // Output: +33600000001
print(phoneNumberTextField.getCountryPhoneCode()) // Output: +33
print(phoneNumberTextField.getRawPhoneNumber()) // Output: 600000001


```

## Customization

FlagKit is used by default but you can customize the list with your own flag icons assets:
```swift
Bundle.FlagIcons = YOUR_FLAG_ICONS_BUNDLE
```
Be sure to set it before initializing a CTKFlagPhoneNumber instance.

## Conception
This library is high inspired of MRCountryPicker library and use libPhoneNumber-iOS library.
https://github.com/xtrinch/MRCountryPicker / https://github.com/iziz/libPhoneNumber-iOS 

## Author

grifas, aurelien.grifasi@chronotruck.com

Don't hesitate to contact me or make a pull request to upgrade this library.

## License

CTKFlagPhoneNumber is available under the Apache license. See the LICENSE file for more info.
