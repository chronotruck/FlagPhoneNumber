import UIKit

public struct FPNCountry: Equatable {
    
    public var code: FPNCountryCode
    public var name: String
    public var phoneCode: String
    var flag: String = ""
    
    init(code: String, name: String, phoneCode: String) {
        self.name = name
        self.phoneCode = phoneCode
        self.code = FPNCountryCode(rawValue: code)!
        flag = getFlag(country: code)
    }
    
    static public func ==(lhs: FPNCountry, rhs: FPNCountry) -> Bool {
        return lhs.code == rhs.code
    }
    
    func getFlag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}
