# FlagPhoneNumber

FlagPhoneNumber is a phone number textfield with a fancy country code picker.   

[![CI Status](http://img.shields.io/travis/grifas/FlagPhoneNumber.svg?style=flat)](https://travis-ci.org/chronotruck/FlagPhoneNumber)
[![Version](https://img.shields.io/cocoapods/v/FlagPhoneNumber.svg?style=flat)](http://cocoapods.org/pods/FlagPhoneNumber)
[![License](https://img.shields.io/cocoapods/l/FlagPhoneNumber.svg?style=flat)](http://cocoapods.org/pods/FlagPhoneNumber)
[![Platform](https://img.shields.io/cocoapods/p/FlagPhoneNumber.svg?style=flat)](http://cocoapods.org/pods/FlagPhoneNumber)
[![Language](https://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)

## 🌅 Screenshot
<img src="./Screenshot/screenshot_1.PNG" width="288px"> <img src="./Screenshot/screenshot_2.PNG" width="288px"> <img src="./Screenshot/screenshot_3.PNG" width="288px">


## 🌍 Localization

Country names are displayed according to the phone language

## 📲 Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## ⬇️ Installation

FlagPhoneNumber is available through [CocoaPods](http://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage). 

### Carthage

Simply add in your `Cartfile` the following line: 

```ruby
github "chronotruck/FlagPhoneNumber"
```

### Cocoapods

Simply add in your `Podfile` the following line:

```ruby
pod "FlagPhoneNumber"
```

## 🗺 Usage

You can instantiate it in storyboards/xibs or programmatically:

```swift
let phoneNumberTextField = FlagPhoneNumberTextField(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 16, height: 50))

// You can change the chosen flag then set the phone number
phoneNumberTextField.setFlag(for: .FR)
phoneNumberTextField.set(phoneNumber: "0600000001")

// Or directly set the phone number with country code, which will update automatically the flag image
phoneNumberTextField.set(phoneNumber: "+33600000001")
```

## 🚨 FPNTextFieldDelegate

FPNTextFieldDelegate inherites from UITextFieldDelegate so nothing change:

```swift
phoneNumberTextField.delegate = self
```

It provides two methods that lets you know when a country is selected and when the phone number is valid or not. Once a phone number is valid, you can get it in severals formats (E164, International, National, RFC3966):

```swift
extension YourViewController: FPNTextFieldDelegate {

   func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
      print(name, dialCode, code) // Output "France", "+33", "FR"
   }

   func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
      if isValid {
         // Do something...         
         textField.getFormattedPhoneNumber(format: .E164),           // Output "+33600000001"
         textField.getFormattedPhoneNumber(format: .International),  // Output "+33 6 00 00 00 01"
         textField.getFormattedPhoneNumber(format: .National),       // Output "06 00 00 00 01"
         textField.getFormattedPhoneNumber(format: .RFC3966),        // Output "tel:+33-6-00-00-00-01"
         textField.getRawPhoneNumber()                               // Output "600000001"
      } else {
         // Do something...
      }
   }
}
```

## 🎨 Customization

FlagKit is used by default but you can customize the list with your own flag icons assets:
```swift
// Be sure to set it before initializing a FlagPhoneNumber instance.
Bundle.FlagIcons = YOUR_FLAG_ICONS_BUNDLE
```

You can change the size of the flag:
```swift
phoneNumberTextField.flagSize = CGSize(width: 44, height: 44)
```

You can change the edge insets of the flag:
```swift
phoneNumberTextField.flagButtonEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10)
```

If you set the parentViewController programmatically or from `@IBOutlet`,  a search button appears in the picker inputAccessoryView to present a country search view controller:
```swift
phoneNumberTextField.parentViewController = self // or from @IBOutlet
```

You can customize the inputAccessoryView of the textfield:
```swift
phoneNumberTextField.textFieldInputAccessoryView = getCustomTextFieldInputAccessoryView(with: items)
```

You can also customize the flag button's properties:
```swift
// This will freeze the flag.
// Only one particular country's phone numbers will be formatted and validated.
// You can set the country by setting the flag as shown earlier.
phoneNumberTextField.flagButton.isUserInteractionEnabled = false
```

You can have in the placeholder an example of a phone number according to the selected country or have your own placeholder:
```swift
phoneNumberTextField.hasPhoneNumberExample = false // true by default
phoneNumberTextField.placeholder = "Phone Number"
```

You can choose which country can appears in the list:
```swift
phoneNumberTextField.setCountries(including: [.FR, .ES, .IT, .BE, .LU, .DE])
```

Or exclude countries from the list:
```swift
phoneNumberTextField.setCountries(excluding: [.AM, .BW, .BA])
```


## ✨ Next Improvments
- [x] Localization
- [x] Country search
- [x] Placeholder
- [x] Exclude/Include countries
- [ ] Any idea ?

## ☕️ Conception
This library is high inspired of MRCountryPicker library and use libPhoneNumber-iOS library.
https://github.com/xtrinch/MRCountryPicker / https://github.com/iziz/libPhoneNumber-iOS

Open source time proudly sponsored by Chronotruck.

## 💁🏻‍♂️ Author
grifas, aurelien.grifasi@chronotruck.com

Don't hesitate to contact me or make a pull request to upgrade this library.

## 📝 License
FlagPhoneNumber is available under the Apache license. See the LICENSE file for more info.
