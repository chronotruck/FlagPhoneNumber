import UIKit

public class FPNCountry {
	
	var code: FPNCountryCode
	var name: String
	var phoneCode: String
	var flag: UIImage?
	
	init(code: String, name: String, phoneCode: String) {
		self.name = name
		self.phoneCode = phoneCode
		self.code = FPNCountryCode(rawValue: code)!
		self.flag = emojiFlagString(for: code)?.emojiToImage()
	}
	
}

extension FPNCountry {
	// Credit to: https://www.timekl.com/blog/2017/08/31/swift-tricks-emoji-flags/
	
	func emojiFlagString(for countryCode: String) -> String! {
		let lowercasedCode = countryCode.lowercased()
		guard lowercasedCode.count == 2 else { return nil }
		guard lowercasedCode.unicodeScalars.reduce(true, { accum, scalar in accum && isLowercaseASCIIScalar(scalar) }) else { return nil }
		
		let indicatorSymbols = lowercasedCode.unicodeScalars.map({ regionalIndicatorSymbol(for: $0) })
		return String(indicatorSymbols.map({ Character($0) }))
	}
	
	func isLowercaseASCIIScalar(_ scalar: Unicode.Scalar) -> Bool {
		return scalar.value >= 0x61 && scalar.value <= 0x7A
	}
	
	func regionalIndicatorSymbol(for scalar: Unicode.Scalar) -> Unicode.Scalar {
		precondition(isLowercaseASCIIScalar(scalar))
		
		// 0x1F1E6 marks the start of the Regional Indicator Symbol range and corresponds to 'A'
		// 0x61 marks the start of the lowercase ASCII alphabet: 'a'
		return Unicode.Scalar(scalar.value + (0x1F1E6 - 0x61))!
	}
	
}

extension String {
	
	func emojiToImage() -> UIImage {
		let attributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 52) ]
		let textSize = self.size(withAttributes: attributes)
		let renderer = UIGraphicsImageRenderer(size: textSize)
		let image = renderer.image(actions: { context in
			self.draw(at: CGPoint.zero, withAttributes: attributes)
		})
		return image
	}
	
}
