import UIKit

public struct FPNCountry: Equatable {

    public var code: FPNCountryCode {
        get {
            FPNCountryCode(rawValue: self.codeStr)!
        }
    }
    private var codeStr: String
	public var name: String
	public var phoneCode: String
	var flag: UIImage? {
        get {
            if let flag = UIImage(named: self.codeStr, in: Bundle.FlagIcons, compatibleWith: nil) {
                return flag
            } else {
                return UIImage(named: "unknown", in: Bundle.FlagIcons, compatibleWith: nil)
            }
        }
    }

	init(code: String, name: String, phoneCode: String) {
		self.name = name
		self.phoneCode = phoneCode
        self.codeStr = code
	}
    
	static public func == (lhs: FPNCountry, rhs: FPNCountry) -> Bool {
		return lhs.code == rhs.code
	}
}
