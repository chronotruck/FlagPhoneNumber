import Foundation

struct FPNCountry {
	var code: String?
	var name: String?
	var phoneCode: String?
	var flag: UIImage?

	init(code: String?, name: String?, phoneCode: String?) {
		self.code = code
		self.name = name
		self.phoneCode = phoneCode

		if let code = code, let flag = UIImage(named: code, in: Bundle.FlagIcons, compatibleWith: nil) {
			self.flag = flag
		} else {
			self.flag = UIImage(named: "unknown", in: Bundle.FlagIcons, compatibleWith: nil)
		}
	}
}
