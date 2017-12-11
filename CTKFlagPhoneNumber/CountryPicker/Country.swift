import Foundation

struct Country {
	var code: String?
	var name: String?
	var phoneCode: String?
	var flag: UIImage? {
		guard let code = self.code else { return nil }
		return UIImage(named: code.uppercased(), in: Bundle.FlagIcons, compatibleWith: nil) ?? UIImage(named: "unknown", in: Bundle.FlagIcons, compatibleWith: nil)
	}
	
	init(code: String?, name: String?, phoneCode: String?) {
		self.code = code
		self.name = name
		self.phoneCode = phoneCode
	}
}
