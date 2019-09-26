//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by Aurelien on 19/05/2019.
//  Copyright © 2019 chronotruck. All rights reserved.
//

import XCTest
@testable import FlagPhoneNumber

class ExampleTests: XCTestCase {

	let textfield = FPNTextField()

	func testSetFlagAndPhoneNumber() {

		textfield.setFlag(for: FPNCountryCode(rawValue: "FR")!)
		XCTAssertEqual(textfield.defaultRegion, "FR")
		XCTAssertEqual(textfield.text, "")


		textfield.set(phoneNumber: "0600000000")
		XCTAssertEqual(textfield.defaultRegion, "FR")
		XCTAssertEqual(textfield.text, "6 00 00 00 00")
	}

	func testSetPhoneNumber() {
		textfield.set(phoneNumber: "+93234567890")

		XCTAssertEqual(textfield.defaultRegion, "AF")
		XCTAssertEqual(textfield.text, "23 456 7890")

		textfield.set(phoneNumber: "+27101234567")

		XCTAssertEqual(textfield.defaultRegion, "ZA")
		XCTAssertEqual(textfield.text, "10 123 4567")

		textfield.set(phoneNumber: "+35522345678")

		XCTAssertEqual(textfield.defaultRegion, "AL")
		XCTAssertEqual(textfield.text, "22 345 678")

		textfield.set(phoneNumber: "+21312345678")

		XCTAssertEqual(textfield.defaultRegion, "DZ")
		XCTAssertEqual(textfield.text, "12 34 56 78")

		textfield.set(phoneNumber: "+4930123456")

		XCTAssertEqual(textfield.defaultRegion, "DE")
		XCTAssertEqual(textfield.text, "30 123456")

		textfield.set(phoneNumber: "+376712345")

		XCTAssertEqual(textfield.defaultRegion, "AD")
		XCTAssertEqual(textfield.text, "712 345")

		textfield.set(phoneNumber: "+244222123456")

		XCTAssertEqual(textfield.defaultRegion, "AO")
		XCTAssertEqual(textfield.text, "222 123 456")

		textfield.set(phoneNumber: "+12644612345")

		XCTAssertEqual(textfield.defaultRegion, "AI")
		XCTAssertEqual(textfield.text, "(264) 461-2345")

		textfield.set(phoneNumber: "+12684601234")

		XCTAssertEqual(textfield.defaultRegion, "AG")
		XCTAssertEqual(textfield.text, "(268) 460-1234")

		textfield.set(phoneNumber: "+966112345678")

		XCTAssertEqual(textfield.defaultRegion, "SA")
		XCTAssertEqual(textfield.text, "11 234 5678")

		textfield.set(phoneNumber: "+541123456789")

		XCTAssertEqual(textfield.defaultRegion, "AR")
		XCTAssertEqual(textfield.text, "11 2345-6789")

		textfield.set(phoneNumber: "+37410123456")

		XCTAssertEqual(textfield.defaultRegion, "AM")
		XCTAssertEqual(textfield.text, "10 123456")

		textfield.set(phoneNumber: "+2975212345")

		XCTAssertEqual(textfield.defaultRegion, "AW")
		XCTAssertEqual(textfield.text, "521 2345")

		textfield.set(phoneNumber: "+61212345678")

		XCTAssertEqual(textfield.defaultRegion, "AU")
		XCTAssertEqual(textfield.text, "2 1234 5678")

		textfield.set(phoneNumber: "+431234567890")

		XCTAssertEqual(textfield.defaultRegion, "AT")
		XCTAssertEqual(textfield.text, "1 234567890")

		textfield.set(phoneNumber: "+994123123456")

		XCTAssertEqual(textfield.defaultRegion, "AZ")
		XCTAssertEqual(textfield.text, "12 312 34 56")

		textfield.set(phoneNumber: "+12423456789")

		XCTAssertEqual(textfield.defaultRegion, "BS")
		XCTAssertEqual(textfield.text, "(242) 345-6789")

		textfield.set(phoneNumber: "+97317001234")

		XCTAssertEqual(textfield.defaultRegion, "BH")
		XCTAssertEqual(textfield.text, "1700 1234")

		textfield.set(phoneNumber: "+88027111234")

		XCTAssertEqual(textfield.defaultRegion, "BD")
		XCTAssertEqual(textfield.text, "2-7111234")

		textfield.set(phoneNumber: "+12464123456")

		XCTAssertEqual(textfield.defaultRegion, "BB")
		XCTAssertEqual(textfield.text, "(246) 412-3456")

		textfield.set(phoneNumber: "+3212345678")

		XCTAssertEqual(textfield.defaultRegion, "BE")
		XCTAssertEqual(textfield.text, "12 34 56 78")

		textfield.set(phoneNumber: "+5012221234")

		XCTAssertEqual(textfield.defaultRegion, "BZ")
		XCTAssertEqual(textfield.text, "222-1234")

		textfield.set(phoneNumber: "+14412345678")

		XCTAssertEqual(textfield.defaultRegion, "BM")
		XCTAssertEqual(textfield.text, "(441) 234-5678")

		textfield.set(phoneNumber: "+22920211234")

		XCTAssertEqual(textfield.defaultRegion, "BJ")
		XCTAssertEqual(textfield.text, "20 21 12 34")

		textfield.set(phoneNumber: "+9752345678")

		XCTAssertEqual(textfield.defaultRegion, "BT")
		XCTAssertEqual(textfield.text, "2 345 678")

		textfield.set(phoneNumber: "+375152450911")

		XCTAssertEqual(textfield.defaultRegion, "BY")
		XCTAssertEqual(textfield.text, "152 45-09-11")

		textfield.set(phoneNumber: "+59122123456")

		XCTAssertEqual(textfield.defaultRegion, "BO")
		XCTAssertEqual(textfield.text, "2 2123456")

		textfield.set(phoneNumber: "+38730212345")

		XCTAssertEqual(textfield.defaultRegion, "BA")
		XCTAssertEqual(textfield.text, "30 212-345")

		textfield.set(phoneNumber: "+2672401234")

		XCTAssertEqual(textfield.defaultRegion, "BW")
		XCTAssertEqual(textfield.text, "240 1234")

		textfield.set(phoneNumber: "+551123456789")

		XCTAssertEqual(textfield.defaultRegion, "BR")
		XCTAssertEqual(textfield.text, "11 2345-6789")

		textfield.set(phoneNumber: "+6732345678")

		XCTAssertEqual(textfield.defaultRegion, "BN")
		XCTAssertEqual(textfield.text, "234 5678")

		textfield.set(phoneNumber: "+3592123456")

		XCTAssertEqual(textfield.defaultRegion, "BG")
		XCTAssertEqual(textfield.text, "2 123 456")

		textfield.set(phoneNumber: "+22620491234")

		XCTAssertEqual(textfield.defaultRegion, "BF")
		XCTAssertEqual(textfield.text, "20 49 12 34")

		textfield.set(phoneNumber: "+25722201234")

		XCTAssertEqual(textfield.defaultRegion, "BI")
		XCTAssertEqual(textfield.text, "22 20 12 34")

		textfield.set(phoneNumber: "+85523756789")

		XCTAssertEqual(textfield.defaultRegion, "KH")
		XCTAssertEqual(textfield.text, "23 756 789")

		textfield.set(phoneNumber: "+237222123456")

		XCTAssertEqual(textfield.defaultRegion, "CM")
		XCTAssertEqual(textfield.text, "2 22 12 34 56")

		textfield.set(phoneNumber: "+12042345678")

		XCTAssertEqual(textfield.defaultRegion, "CA")
		XCTAssertEqual(textfield.text, "(204) 234-5678")

		textfield.set(phoneNumber: "+2382211234")

		XCTAssertEqual(textfield.defaultRegion, "CV")
		XCTAssertEqual(textfield.text, "221 12 34")

		textfield.set(phoneNumber: "+56221234567")

		XCTAssertEqual(textfield.defaultRegion, "CL")
		XCTAssertEqual(textfield.text, "2 2123 4567")

		textfield.set(phoneNumber: "+861012345678")

		XCTAssertEqual(textfield.defaultRegion, "CN")
		XCTAssertEqual(textfield.text, "10 1234 5678")

		textfield.set(phoneNumber: "+35722345678")

		XCTAssertEqual(textfield.defaultRegion, "CY")
		XCTAssertEqual(textfield.text, "22 345678")

		textfield.set(phoneNumber: "+5712345678")

		XCTAssertEqual(textfield.defaultRegion, "CO")
		XCTAssertEqual(textfield.text, "1 2345678")

		textfield.set(phoneNumber: "+2697712345")

		XCTAssertEqual(textfield.defaultRegion, "KM")
		XCTAssertEqual(textfield.text, "771 23 45")

		textfield.set(phoneNumber: "+242222123456")

		XCTAssertEqual(textfield.defaultRegion, "CG")
		XCTAssertEqual(textfield.text, "22 212 3456")

		textfield.set(phoneNumber: "+2431234567")

		XCTAssertEqual(textfield.defaultRegion, "CD")
		XCTAssertEqual(textfield.text, "12 34567")

		textfield.set(phoneNumber: "+85021234567")

		XCTAssertEqual(textfield.defaultRegion, "KP")
		XCTAssertEqual(textfield.text, "2 123 4567")

		textfield.set(phoneNumber: "+8222123456")

		XCTAssertEqual(textfield.defaultRegion, "KR")
		XCTAssertEqual(textfield.text, "2-212-3456")

		textfield.set(phoneNumber: "+50622123456")

		XCTAssertEqual(textfield.defaultRegion, "CR")
		XCTAssertEqual(textfield.text, "2212 3456")

		textfield.set(phoneNumber: "+22521234567")

		XCTAssertEqual(textfield.defaultRegion, "CI")
		XCTAssertEqual(textfield.text, "21 23 45 67")

		textfield.set(phoneNumber: "+38512345678")

		XCTAssertEqual(textfield.defaultRegion, "HR")
		XCTAssertEqual(textfield.text, "1 2345 678")

		textfield.set(phoneNumber: "+5371234567")

		XCTAssertEqual(textfield.defaultRegion, "CU")
		XCTAssertEqual(textfield.text, "7 1234567")

		textfield.set(phoneNumber: "+4532123456")

		XCTAssertEqual(textfield.defaultRegion, "DK")
		XCTAssertEqual(textfield.text, "32 12 34 56")

		textfield.set(phoneNumber: "+25321360003")

		XCTAssertEqual(textfield.defaultRegion, "DJ")
		XCTAssertEqual(textfield.text, "21 36 00 03")

		textfield.set(phoneNumber: "+17674201234")

		XCTAssertEqual(textfield.defaultRegion, "DM")
		XCTAssertEqual(textfield.text, "(767) 420-1234")

		textfield.set(phoneNumber: "+50321234567")

		XCTAssertEqual(textfield.defaultRegion, "SV")
		XCTAssertEqual(textfield.text, "2123 4567")

		textfield.set(phoneNumber: "+34810123456")

		XCTAssertEqual(textfield.defaultRegion, "ES")
		XCTAssertEqual(textfield.text, "810 12 34 56")

		textfield.set(phoneNumber: "+3723212345")

		XCTAssertEqual(textfield.defaultRegion, "EE")
		XCTAssertEqual(textfield.text, "321 2345")

		textfield.set(phoneNumber: "+20234567890")

		XCTAssertEqual(textfield.defaultRegion, "EG")
		XCTAssertEqual(textfield.text, "2 34567890")

		textfield.set(phoneNumber: "+97122345678")

		XCTAssertEqual(textfield.defaultRegion, "AE")
		XCTAssertEqual(textfield.text, "2 234 5678")

		textfield.set(phoneNumber: "+59322123456")

		XCTAssertEqual(textfield.defaultRegion, "EC")
		XCTAssertEqual(textfield.text, "2 212-3456")

		textfield.set(phoneNumber: "+2918370362")

		XCTAssertEqual(textfield.defaultRegion, "ER")
		XCTAssertEqual(textfield.text, "8 370 362")

		textfield.set(phoneNumber: "+3966981246575")

		XCTAssertEqual(textfield.defaultRegion, "VA")
		XCTAssertEqual(textfield.text, "6 6981 2345")

		textfield.set(phoneNumber: "+6913201234")

		XCTAssertEqual(textfield.defaultRegion, "FM")
		XCTAssertEqual(textfield.text, "320 1234")

		textfield.set(phoneNumber: "+12015550123")

		XCTAssertEqual(textfield.defaultRegion, "US")
		XCTAssertEqual(textfield.text, "(201) 555-0123")

		textfield.set(phoneNumber: "+251111112345")

		XCTAssertEqual(textfield.defaultRegion, "ET")
		XCTAssertEqual(textfield.text, "11 111 2345")

		textfield.set(phoneNumber: "+6793212345")

		XCTAssertEqual(textfield.defaultRegion, "FJ")
		XCTAssertEqual(textfield.text, "321 2345")

		textfield.set(phoneNumber: "+358131234567")

		XCTAssertEqual(textfield.defaultRegion, "FI")
		XCTAssertEqual(textfield.text, "13 1234567")

		textfield.set(phoneNumber: "+33123456789")

		XCTAssertEqual(textfield.defaultRegion, "FR")
		XCTAssertEqual(textfield.text, "1 23 45 67 89")

		textfield.set(phoneNumber: "+2414422222")

		XCTAssertEqual(textfield.defaultRegion, "GA")
		XCTAssertEqual(textfield.text, "4 42 22 22")

		textfield.set(phoneNumber: "+2205661234")

		XCTAssertEqual(textfield.defaultRegion, "GM")
		XCTAssertEqual(textfield.text, "566 1234")

		textfield.set(phoneNumber: "+995322123456")

		XCTAssertEqual(textfield.defaultRegion, "GE")
		XCTAssertEqual(textfield.text, "32 212 34 56")

		textfield.set(phoneNumber: "+233302345678")

		XCTAssertEqual(textfield.defaultRegion, "GH")
		XCTAssertEqual(textfield.text, "30 234 5678")

		textfield.set(phoneNumber: "+35020012345")

		XCTAssertEqual(textfield.defaultRegion, "GI")
		XCTAssertEqual(textfield.text, "200 12345")

		textfield.set(phoneNumber: "+14732691234")

		XCTAssertEqual(textfield.defaultRegion, "GD")
		XCTAssertEqual(textfield.text, "(473) 269-1234")

		textfield.set(phoneNumber: "+302123456789")

		XCTAssertEqual(textfield.defaultRegion, "GR")
		XCTAssertEqual(textfield.text, "21 2345 6789")

		textfield.set(phoneNumber: "+299321000")

		XCTAssertEqual(textfield.defaultRegion, "GL")
		XCTAssertEqual(textfield.text, "32 10 00")

		textfield.set(phoneNumber: "+590590201234")

		XCTAssertEqual(textfield.defaultRegion, "GP")
		XCTAssertEqual(textfield.text, "590 20 12 34")

		textfield.set(phoneNumber: "+16713001234")

		XCTAssertEqual(textfield.defaultRegion, "GU")
		XCTAssertEqual(textfield.text, "(671) 300-1234")

		textfield.set(phoneNumber: "+50222456789")

		XCTAssertEqual(textfield.defaultRegion, "GT")
		XCTAssertEqual(textfield.text, "2245 6789")

		textfield.set(phoneNumber: "+441481256789")

		XCTAssertEqual(textfield.defaultRegion, "GG")
		XCTAssertEqual(textfield.text, "1481 256789")

		textfield.set(phoneNumber: "+22430241234")

		XCTAssertEqual(textfield.defaultRegion, "GN")
		XCTAssertEqual(textfield.text, "30 24 12 34")

		textfield.set(phoneNumber: "+240333091234")

		XCTAssertEqual(textfield.defaultRegion, "GQ")
		XCTAssertEqual(textfield.text, "333 091 234")

		textfield.set(phoneNumber: "+245443201234")

		XCTAssertEqual(textfield.defaultRegion, "GW")
		XCTAssertEqual(textfield.text, "443 201 234")

		textfield.set(phoneNumber: "+5922201234")

		XCTAssertEqual(textfield.defaultRegion, "GY")
		XCTAssertEqual(textfield.text, "220 1234")

		textfield.set(phoneNumber: "+594594101234")

		XCTAssertEqual(textfield.defaultRegion, "GF")
		XCTAssertEqual(textfield.text, "594 10 12 34")

		textfield.set(phoneNumber: "+50922453300")

		XCTAssertEqual(textfield.defaultRegion, "HT")
		XCTAssertEqual(textfield.text, "22 45 3300")

		textfield.set(phoneNumber: "+50422123456")

		XCTAssertEqual(textfield.defaultRegion, "HN")
		XCTAssertEqual(textfield.text, "2212-3456")

		textfield.set(phoneNumber: "+85221234567")

		XCTAssertEqual(textfield.defaultRegion, "HK")
		XCTAssertEqual(textfield.text, "2123 4567")

		textfield.set(phoneNumber: "+3612345678")

		XCTAssertEqual(textfield.defaultRegion, "HU")
		XCTAssertEqual(textfield.text, "1 234 5678")

		textfield.set(phoneNumber: "+911123456789")

		XCTAssertEqual(textfield.defaultRegion, "IN")
		XCTAssertEqual(textfield.text, "11 2345 6789")

		textfield.set(phoneNumber: "+62612345678")

		XCTAssertEqual(textfield.defaultRegion, "ID")
		XCTAssertEqual(textfield.text, "61 2345678")

		textfield.set(phoneNumber: "+96412345678")

		XCTAssertEqual(textfield.defaultRegion, "IQ")
		XCTAssertEqual(textfield.text, "1 234 5678")

		textfield.set(phoneNumber: "+982123456789")

		XCTAssertEqual(textfield.defaultRegion, "IR")
		XCTAssertEqual(textfield.text, "21 2345 6789")

		textfield.set(phoneNumber: "+3532212345")

		XCTAssertEqual(textfield.defaultRegion, "IE")
		XCTAssertEqual(textfield.text, "22 12345")

		textfield.set(phoneNumber: "+3544101234")

		XCTAssertEqual(textfield.defaultRegion, "IS")
		XCTAssertEqual(textfield.text, "410 1234")

		textfield.set(phoneNumber: "+97221234567")

		XCTAssertEqual(textfield.defaultRegion, "IL")
		XCTAssertEqual(textfield.text, "2-123-4567")

		textfield.set(phoneNumber: "+39054988")

		XCTAssertEqual(textfield.defaultRegion, "IT")
		XCTAssertEqual(textfield.text, "54 988")

		textfield.set(phoneNumber: "+61891641234")

		XCTAssertEqual(textfield.defaultRegion, "CX")
		XCTAssertEqual(textfield.text, "8 9164 1234")

		textfield.set(phoneNumber: "+672106609")

		XCTAssertEqual(textfield.defaultRegion, "NF")
		XCTAssertEqual(textfield.text, "10 6609")

		textfield.set(phoneNumber: "+441624756789")

		XCTAssertEqual(textfield.defaultRegion, "IM")
		XCTAssertEqual(textfield.text, "1624 756789")

		textfield.set(phoneNumber: "+358181234567")

		XCTAssertEqual(textfield.defaultRegion, "AX")
		XCTAssertEqual(textfield.text, "18 1234567")

		textfield.set(phoneNumber: "+13452221234")

		XCTAssertEqual(textfield.defaultRegion, "KY")
		XCTAssertEqual(textfield.text, "(345) 222-1234")

		textfield.set(phoneNumber: "+61891621234")

		XCTAssertEqual(textfield.defaultRegion, "CC")
		XCTAssertEqual(textfield.text, "8 9162 1234")

		textfield.set(phoneNumber: "+68221234")

		XCTAssertEqual(textfield.defaultRegion, "CK")
		XCTAssertEqual(textfield.text, "21 234")

		textfield.set(phoneNumber: "+298201234")

		XCTAssertEqual(textfield.defaultRegion, "FO")
		XCTAssertEqual(textfield.text, "201234")

		textfield.set(phoneNumber: "+50031234")

		XCTAssertEqual(textfield.defaultRegion, "FK")
		XCTAssertEqual(textfield.text, "31234")

		textfield.set(phoneNumber: "+16702345678")

		XCTAssertEqual(textfield.defaultRegion, "MP")
		XCTAssertEqual(textfield.text, "(670) 234-5678")

		textfield.set(phoneNumber: "+6922471234")

		XCTAssertEqual(textfield.defaultRegion, "MH")
		XCTAssertEqual(textfield.text, "247-1234")

		textfield.set(phoneNumber: "+67740123")

		XCTAssertEqual(textfield.defaultRegion, "SB")
		XCTAssertEqual(textfield.text, "40 123")

		textfield.set(phoneNumber: "+16497121234")

		XCTAssertEqual(textfield.defaultRegion, "TC")
		XCTAssertEqual(textfield.text, "(649) 712-1234")

		textfield.set(phoneNumber: "+12842291234")

		XCTAssertEqual(textfield.defaultRegion, "VG")
		XCTAssertEqual(textfield.text, "(284) 229-1234")

		textfield.set(phoneNumber: "+13406421234")

		XCTAssertEqual(textfield.defaultRegion, "VI")
		XCTAssertEqual(textfield.text, "(340) 642-1234")

		textfield.set(phoneNumber: "+18765123456")

		XCTAssertEqual(textfield.defaultRegion, "JM")
		XCTAssertEqual(textfield.text, "(876) 512-3456")

		textfield.set(phoneNumber: "+81312345678")

		XCTAssertEqual(textfield.defaultRegion, "JP")
		XCTAssertEqual(textfield.text, "3-1234-5678")

		textfield.set(phoneNumber: "+441534456789")

		XCTAssertEqual(textfield.defaultRegion, "JE")
		XCTAssertEqual(textfield.text, "1534 456789")

		textfield.set(phoneNumber: "+96262001234")

		XCTAssertEqual(textfield.defaultRegion, "JO")
		XCTAssertEqual(textfield.text, "6 200 1234")

		textfield.set(phoneNumber: "+77123456789")

		XCTAssertEqual(textfield.defaultRegion, "KZ")
		XCTAssertEqual(textfield.text, "71234 5 67 89")

		textfield.set(phoneNumber: "+254202012345")

		XCTAssertEqual(textfield.defaultRegion, "KE")
		XCTAssertEqual(textfield.text, "20 2012345")

		textfield.set(phoneNumber: "+996312123456")

		XCTAssertEqual(textfield.defaultRegion, "KG")
		XCTAssertEqual(textfield.text, "312 123 456")

		textfield.set(phoneNumber: "+68631234")

		XCTAssertEqual(textfield.defaultRegion, "KI")
		XCTAssertEqual(textfield.text, "31234")

		textfield.set(phoneNumber: "+96522345678")

		XCTAssertEqual(textfield.defaultRegion, "KW")
		XCTAssertEqual(textfield.text, "2234 5678")

		textfield.set(phoneNumber: "+262262161234")

		XCTAssertEqual(textfield.defaultRegion, "RE")
		XCTAssertEqual(textfield.text, "262 16 12 34")

		textfield.set(phoneNumber: "+85621212862")

		XCTAssertEqual(textfield.defaultRegion, "LA")
		XCTAssertEqual(textfield.text, "21 212 862")

		textfield.set(phoneNumber: "+26622123456")

		XCTAssertEqual(textfield.defaultRegion, "LS")
		XCTAssertEqual(textfield.text, "2212 3456")

		textfield.set(phoneNumber: "+37163123456")

		XCTAssertEqual(textfield.defaultRegion, "LV")
		XCTAssertEqual(textfield.text, "63 123 456")

		textfield.set(phoneNumber: "+9611123456")

		XCTAssertEqual(textfield.defaultRegion, "LB")
		XCTAssertEqual(textfield.text, "1 123 456")

		textfield.set(phoneNumber: "+23121234567")

		XCTAssertEqual(textfield.defaultRegion, "LR")
		XCTAssertEqual(textfield.text, "21 234 567")

		textfield.set(phoneNumber: "+218212345678")

		XCTAssertEqual(textfield.defaultRegion, "LY")
		XCTAssertEqual(textfield.text, "21-2345678")

		textfield.set(phoneNumber: "+4232345678")

		XCTAssertEqual(textfield.defaultRegion, "LI")
		XCTAssertEqual(textfield.text, "234 56 78")

		textfield.set(phoneNumber: "+37031234567")

		XCTAssertEqual(textfield.defaultRegion, "LT")
		XCTAssertEqual(textfield.text, "312 34567")

		textfield.set(phoneNumber: "+35227123456")

		XCTAssertEqual(textfield.defaultRegion, "LU")
		XCTAssertEqual(textfield.text, "27 12 34 56")

		textfield.set(phoneNumber: "+85328212345")

		XCTAssertEqual(textfield.defaultRegion, "MO")
		XCTAssertEqual(textfield.text, "2821 2345")

		textfield.set(phoneNumber: "+38922212345")

		XCTAssertEqual(textfield.defaultRegion, "MK")
		XCTAssertEqual(textfield.text, "2 221 2345")

		textfield.set(phoneNumber: "+261202123456")

		XCTAssertEqual(textfield.defaultRegion, "MG")
		XCTAssertEqual(textfield.text, "20 21 234 56")

		textfield.set(phoneNumber: "+60323856789")

		XCTAssertEqual(textfield.defaultRegion, "MY")
		XCTAssertEqual(textfield.text, "3-2385 6789")

		textfield.set(phoneNumber: "+2651234567")

		XCTAssertEqual(textfield.defaultRegion, "MW")
		XCTAssertEqual(textfield.text, "1 234 567")

		textfield.set(phoneNumber: "+9606701234")

		XCTAssertEqual(textfield.defaultRegion, "MV")
		XCTAssertEqual(textfield.text, "670-1234")

		textfield.set(phoneNumber: "+22320212345")

		XCTAssertEqual(textfield.defaultRegion, "ML")
		XCTAssertEqual(textfield.text, "20 21 23 45")

		textfield.set(phoneNumber: "+35621001234")

		XCTAssertEqual(textfield.defaultRegion, "MT")
		XCTAssertEqual(textfield.text, "2100 1234")

		textfield.set(phoneNumber: "+212520123456")

		XCTAssertEqual(textfield.defaultRegion, "MA")
		XCTAssertEqual(textfield.text, "520-123456")

		textfield.set(phoneNumber: "+596596301234")

		XCTAssertEqual(textfield.defaultRegion, "MQ")
		XCTAssertEqual(textfield.text, "596 30 12 34")

		textfield.set(phoneNumber: "+2302012345")

		XCTAssertEqual(textfield.defaultRegion, "MU")
		XCTAssertEqual(textfield.text, "201 2345")

		textfield.set(phoneNumber: "+22235123456")

		XCTAssertEqual(textfield.defaultRegion, "MR")
		XCTAssertEqual(textfield.text, "35 12 34 56")

		textfield.set(phoneNumber: "+262269601234")

		XCTAssertEqual(textfield.defaultRegion, "YT")
		XCTAssertEqual(textfield.text, "269 60 12 34")

		textfield.set(phoneNumber: "+522221234567")

		XCTAssertEqual(textfield.defaultRegion, "MX")
		XCTAssertEqual(textfield.text, "222 123 4567")

		textfield.set(phoneNumber: "+37322212345")

		XCTAssertEqual(textfield.defaultRegion, "MD")
		XCTAssertEqual(textfield.text, "22 212 345")

		textfield.set(phoneNumber: "+37799123456")

		XCTAssertEqual(textfield.defaultRegion, "MC")
		XCTAssertEqual(textfield.text, "99 12 34 56")

		textfield.set(phoneNumber: "+97650123456")

		XCTAssertEqual(textfield.defaultRegion, "MN")
		XCTAssertEqual(textfield.text, "5012 3456")

		textfield.set(phoneNumber: "+38230234567")

		XCTAssertEqual(textfield.defaultRegion, "ME")
		XCTAssertEqual(textfield.text, "30 234 567")

		textfield.set(phoneNumber: "+16644912345")

		XCTAssertEqual(textfield.defaultRegion, "MS")
		XCTAssertEqual(textfield.text, "(664) 491-2345")

		textfield.set(phoneNumber: "+25821123456")

		XCTAssertEqual(textfield.defaultRegion, "MZ")
		XCTAssertEqual(textfield.text, "21 123 456")

		textfield.set(phoneNumber: "+951234567")

		XCTAssertEqual(textfield.defaultRegion, "MM")
		XCTAssertEqual(textfield.text, "1 234 567")

		textfield.set(phoneNumber: "+26461221234")

		XCTAssertEqual(textfield.defaultRegion, "NA")
		XCTAssertEqual(textfield.text, "61 221 234")

		textfield.set(phoneNumber: "+6744441234")

		XCTAssertEqual(textfield.defaultRegion, "NR")
		XCTAssertEqual(textfield.text, "444 1234")

		textfield.set(phoneNumber: "+97714567890")

		XCTAssertEqual(textfield.defaultRegion, "NP")
		XCTAssertEqual(textfield.text, "1-4567890")

		textfield.set(phoneNumber: "+50521234567")

		XCTAssertEqual(textfield.defaultRegion, "NI")
		XCTAssertEqual(textfield.text, "2123 4567")

		textfield.set(phoneNumber: "+22720201234")

		XCTAssertEqual(textfield.defaultRegion, "NE")
		XCTAssertEqual(textfield.text, "20 20 12 34")

		textfield.set(phoneNumber: "+23412345678")

		XCTAssertEqual(textfield.defaultRegion, "NG")
		XCTAssertEqual(textfield.text, "1 234 5678")

		textfield.set(phoneNumber: "+6834002")

		XCTAssertEqual(textfield.defaultRegion, "NU")
		XCTAssertEqual(textfield.text, "400 2")

		textfield.set(phoneNumber: "+4721234567")

		XCTAssertEqual(textfield.defaultRegion, "NO")
		XCTAssertEqual(textfield.text, "21 23 45 67")

		textfield.set(phoneNumber: "+687201234")

		XCTAssertEqual(textfield.defaultRegion, "NC")
		XCTAssertEqual(textfield.text, "20.12.34")

		textfield.set(phoneNumber: "+6432345678")

		XCTAssertEqual(textfield.defaultRegion, "NZ")
		XCTAssertEqual(textfield.text, "3-234 5678")

		textfield.set(phoneNumber: "+96823123456")

		XCTAssertEqual(textfield.defaultRegion, "OM")
		XCTAssertEqual(textfield.text, "23 123456")

		textfield.set(phoneNumber: "+256312345678")

		XCTAssertEqual(textfield.defaultRegion, "UG")
		XCTAssertEqual(textfield.text, "31 2345678")

		textfield.set(phoneNumber: "+998662345678")

		XCTAssertEqual(textfield.defaultRegion, "UZ")
		XCTAssertEqual(textfield.text, "66 234 56 78")

		textfield.set(phoneNumber: "+922123456789")

		XCTAssertEqual(textfield.defaultRegion, "PK")
		XCTAssertEqual(textfield.text, "21 23456789")

		textfield.set(phoneNumber: "+6802771234")

		XCTAssertEqual(textfield.defaultRegion, "PW")
		XCTAssertEqual(textfield.text, "277 1234")

		textfield.set(phoneNumber: "+5072001234")

		XCTAssertEqual(textfield.defaultRegion, "PA")
		XCTAssertEqual(textfield.text, "200-1234")

		textfield.set(phoneNumber: "+6753123456")

		XCTAssertEqual(textfield.defaultRegion, "PG")
		XCTAssertEqual(textfield.text, "312 3456")

		textfield.set(phoneNumber: "+595212345678")

		XCTAssertEqual(textfield.defaultRegion, "PY")
		XCTAssertEqual(textfield.text, "21 234 5678")

		textfield.set(phoneNumber: "+31101234567")

		XCTAssertEqual(textfield.defaultRegion, "NL")
		XCTAssertEqual(textfield.text, "10 123 4567")

		textfield.set(phoneNumber: "+5111234567")

		XCTAssertEqual(textfield.defaultRegion, "PE")
		XCTAssertEqual(textfield.text, "1 1234567")

		textfield.set(phoneNumber: "+6321234567")

		XCTAssertEqual(textfield.defaultRegion, "PH")
		XCTAssertEqual(textfield.text, "2 123 4567")

		textfield.set(phoneNumber: "+48123456789")

		XCTAssertEqual(textfield.defaultRegion, "PL")
		XCTAssertEqual(textfield.text, "12 345 67 89")

		textfield.set(phoneNumber: "+68940412345")

		XCTAssertEqual(textfield.defaultRegion, "PF")
		XCTAssertEqual(textfield.text, "40 41 23 45")

		textfield.set(phoneNumber: "+17872345678")

		XCTAssertEqual(textfield.defaultRegion, "PR")
		XCTAssertEqual(textfield.text, "(787) 234-5678")

		textfield.set(phoneNumber: "+351212345678")

		XCTAssertEqual(textfield.defaultRegion, "PT")
		XCTAssertEqual(textfield.text, "21 234 5678")

		textfield.set(phoneNumber: "+97444123456")

		XCTAssertEqual(textfield.defaultRegion, "QA")
		XCTAssertEqual(textfield.text, "4412 3456")

		textfield.set(phoneNumber: "+23621612345")

		XCTAssertEqual(textfield.defaultRegion, "CF")
		XCTAssertEqual(textfield.text, "21 61 23 45")

		textfield.set(phoneNumber: "+18092345678")

		XCTAssertEqual(textfield.defaultRegion, "DO")
		XCTAssertEqual(textfield.text, "(809) 234-5678")

		textfield.set(phoneNumber: "+40211234567")

		XCTAssertEqual(textfield.defaultRegion, "RO")
		XCTAssertEqual(textfield.text, "21 123 4567")

		textfield.set(phoneNumber: "+441212345678")

		XCTAssertEqual(textfield.defaultRegion, "GB")
		XCTAssertEqual(textfield.text, "121 234 5678")

		textfield.set(phoneNumber: "+73011234567")

		XCTAssertEqual(textfield.defaultRegion, "RU")
		XCTAssertEqual(textfield.text, "301 123-45-67")

		textfield.set(phoneNumber: "+250250123456")

		XCTAssertEqual(textfield.defaultRegion, "RW")
		XCTAssertEqual(textfield.text, "250 123 456")

		textfield.set(phoneNumber: "+590590271234")

		XCTAssertEqual(textfield.defaultRegion, "BL")
		XCTAssertEqual(textfield.text, "590 27 12 34")

		textfield.set(phoneNumber: "+18692361234")

		XCTAssertEqual(textfield.defaultRegion, "KN")
		XCTAssertEqual(textfield.text, "(869) 236-1234")

		textfield.set(phoneNumber: "+3780549876811")

		XCTAssertEqual(textfield.defaultRegion, "SM")
		XCTAssertEqual(textfield.text, "549876811")

		textfield.set(phoneNumber: "+590590271234")

		XCTAssertEqual(textfield.defaultRegion, "MF")
		XCTAssertEqual(textfield.text, "590 27-1234")

		textfield.set(phoneNumber: "+508411234")

		XCTAssertEqual(textfield.defaultRegion, "PM")
		XCTAssertEqual(textfield.text, "41 12 34")

		textfield.set(phoneNumber: "+17842661234")

		XCTAssertEqual(textfield.defaultRegion, "VC")
		XCTAssertEqual(textfield.text, "(784) 266-1234")

		textfield.set(phoneNumber: "+29022158")

		XCTAssertEqual(textfield.defaultRegion, "SH")
		XCTAssertEqual(textfield.text, "22158")

		textfield.set(phoneNumber: "+17584305678")

		XCTAssertEqual(textfield.defaultRegion, "LC")
		XCTAssertEqual(textfield.text, "(758) 430-5678")

		textfield.set(phoneNumber: "+68522123")

		XCTAssertEqual(textfield.defaultRegion, "WS")
		XCTAssertEqual(textfield.text, "22123")

		textfield.set(phoneNumber: "+16846221234")

		XCTAssertEqual(textfield.defaultRegion, "AS")
		XCTAssertEqual(textfield.text, "(684) 622-1234")

		textfield.set(phoneNumber: "+2392221234")

		XCTAssertEqual(textfield.defaultRegion, "ST")
		XCTAssertEqual(textfield.text, "222 1234")

		textfield.set(phoneNumber: "+38110234567")

		XCTAssertEqual(textfield.defaultRegion, "RS")
		XCTAssertEqual(textfield.text, "10 234567")

		textfield.set(phoneNumber: "+2484217123")

		XCTAssertEqual(textfield.defaultRegion, "SC")
		XCTAssertEqual(textfield.text, "4 217 123")

		textfield.set(phoneNumber: "+221301012345")

		XCTAssertEqual(textfield.defaultRegion, "SN")
		XCTAssertEqual(textfield.text, "30 101 23 45")

		textfield.set(phoneNumber: "+23222221234")

		XCTAssertEqual(textfield.defaultRegion, "SL")
		XCTAssertEqual(textfield.text, "22 221234")

		textfield.set(phoneNumber: "+6561234567")

		XCTAssertEqual(textfield.defaultRegion, "SG")
		XCTAssertEqual(textfield.text, "6123 4567")

		textfield.set(phoneNumber: "+421221234567")

		XCTAssertEqual(textfield.defaultRegion, "SK")
		XCTAssertEqual(textfield.text, "2/212 345 67")

		textfield.set(phoneNumber: "+38611234567")

		XCTAssertEqual(textfield.defaultRegion, "SI")
		XCTAssertEqual(textfield.text, "1 123 45 67")

		textfield.set(phoneNumber: "+2524012345")

		XCTAssertEqual(textfield.defaultRegion, "SO")
		XCTAssertEqual(textfield.text, "4 012345")

		textfield.set(phoneNumber: "+249121231234")

		XCTAssertEqual(textfield.defaultRegion, "SD")
		XCTAssertEqual(textfield.text, "12 123 1234")

		textfield.set(phoneNumber: "+211181234567")

		XCTAssertEqual(textfield.defaultRegion, "SS")
		XCTAssertEqual(textfield.text, "181 234 567")

		textfield.set(phoneNumber: "+94112345678")

		XCTAssertEqual(textfield.defaultRegion, "LK")
		XCTAssertEqual(textfield.text, "112 345 678")

		textfield.set(phoneNumber: "+468123456")

		XCTAssertEqual(textfield.defaultRegion, "SE")
		XCTAssertEqual(textfield.text, "8-12 34 56")

		textfield.set(phoneNumber: "+41212345678")

		XCTAssertEqual(textfield.defaultRegion, "CH")
		XCTAssertEqual(textfield.text, "21 234 56 78")

		textfield.set(phoneNumber: "+597211234")

		XCTAssertEqual(textfield.defaultRegion, "SR")
		XCTAssertEqual(textfield.text, "211-234")

		textfield.set(phoneNumber: "+4779123456")

		XCTAssertEqual(textfield.defaultRegion, "SJ")
		XCTAssertEqual(textfield.text, "79 12 34 56")

		textfield.set(phoneNumber: "+26822171234")

		XCTAssertEqual(textfield.defaultRegion, "SZ")
		XCTAssertEqual(textfield.text, "2217 1234")

		textfield.set(phoneNumber: "+963112345678")

		XCTAssertEqual(textfield.defaultRegion, "SY")
		XCTAssertEqual(textfield.text, "11 234 5678")

		textfield.set(phoneNumber: "+992372123456")

		XCTAssertEqual(textfield.defaultRegion, "TJ")
		XCTAssertEqual(textfield.text, "372 12 3456")

		textfield.set(phoneNumber: "+886221234567")

		XCTAssertEqual(textfield.defaultRegion, "TW")
		XCTAssertEqual(textfield.text, "2 2123 4567")

		textfield.set(phoneNumber: "+255222345678")

		XCTAssertEqual(textfield.defaultRegion, "TZ")
		XCTAssertEqual(textfield.text, "22 234 5678")

		textfield.set(phoneNumber: "+23522501234")

		XCTAssertEqual(textfield.defaultRegion, "TD")
		XCTAssertEqual(textfield.text, "22 50 12 34")

		textfield.set(phoneNumber: "+420212345678")

		XCTAssertEqual(textfield.defaultRegion, "CZ")
		XCTAssertEqual(textfield.text, "212 345 678")

		textfield.set(phoneNumber: "+2463709100")

		XCTAssertEqual(textfield.defaultRegion, "IO")
		XCTAssertEqual(textfield.text, "370 9100")

		textfield.set(phoneNumber: "+97022234567")

		XCTAssertEqual(textfield.defaultRegion, "PS")
		XCTAssertEqual(textfield.text, "2 223 4567")

		textfield.set(phoneNumber: "+6621234567")

		XCTAssertEqual(textfield.defaultRegion, "TH")
		XCTAssertEqual(textfield.text, "2 123 4567")

		textfield.set(phoneNumber: "+6702112345")

		XCTAssertEqual(textfield.defaultRegion, "TL")
		XCTAssertEqual(textfield.text, "211 2345")

		textfield.set(phoneNumber: "+22822212345")

		XCTAssertEqual(textfield.defaultRegion, "TG")
		XCTAssertEqual(textfield.text, "22 21 23 45")

		textfield.set(phoneNumber: "+6903101")

		XCTAssertEqual(textfield.defaultRegion, "TK")
		XCTAssertEqual(textfield.text, "3101")

		textfield.set(phoneNumber: "+67620123")

		XCTAssertEqual(textfield.defaultRegion, "TO")
		XCTAssertEqual(textfield.text, "20-123")

		textfield.set(phoneNumber: "+18682211234")

		XCTAssertEqual(textfield.defaultRegion, "TT")
		XCTAssertEqual(textfield.text, "(868) 221-1234")

		textfield.set(phoneNumber: "+21671234567")

		XCTAssertEqual(textfield.defaultRegion, "TN")
		XCTAssertEqual(textfield.text, "71 234 567")

		textfield.set(phoneNumber: "+99312345678")

		XCTAssertEqual(textfield.defaultRegion, "TM")
		XCTAssertEqual(textfield.text, "12 34-56-78")

		textfield.set(phoneNumber: "+902123456789")

		XCTAssertEqual(textfield.defaultRegion, "TR")
		XCTAssertEqual(textfield.text, "212 345 67 89")

		textfield.set(phoneNumber: "+68820123")

		XCTAssertEqual(textfield.defaultRegion, "TV")
		XCTAssertEqual(textfield.text, "20123")

		textfield.set(phoneNumber: "+380311234567")

		XCTAssertEqual(textfield.defaultRegion, "UA")
		XCTAssertEqual(textfield.text, "3112 34567")

		textfield.set(phoneNumber: "+59821231234")

		XCTAssertEqual(textfield.defaultRegion, "UY")
		XCTAssertEqual(textfield.text, "2123 1234")

		textfield.set(phoneNumber: "+67822123")

		XCTAssertEqual(textfield.defaultRegion, "VU")
		XCTAssertEqual(textfield.text, "221 23")

		textfield.set(phoneNumber: "+582121234567")

		XCTAssertEqual(textfield.defaultRegion, "VE")
		XCTAssertEqual(textfield.text, "212-1234567")

		textfield.set(phoneNumber: "+842101234567")

		XCTAssertEqual(textfield.defaultRegion, "VN")
		XCTAssertEqual(textfield.text, "210 1234 567")

		textfield.set(phoneNumber: "+681501234")

		XCTAssertEqual(textfield.defaultRegion, "WF")
		XCTAssertEqual(textfield.text, "50 12 34")

		textfield.set(phoneNumber: "+9671234567")

		XCTAssertEqual(textfield.defaultRegion, "YE")
		XCTAssertEqual(textfield.text, "1 234 567")

		textfield.set(phoneNumber: "+260211234567")

		XCTAssertEqual(textfield.defaultRegion, "ZM")
		XCTAssertEqual(textfield.text, "211 234 567")

		textfield.set(phoneNumber: "+2631312345")

		XCTAssertEqual(textfield.defaultRegion, "ZW")
		XCTAssertEqual(textfield.text, "13 12345")
	}

	func testSetFlag() {

		textfield.setFlag(for: FPNCountryCode(rawValue: "AF")!)
		XCTAssertEqual(textfield.defaultRegion, "AF")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AL")!)
		XCTAssertEqual(textfield.defaultRegion, "AL")

		textfield.setFlag(for: FPNCountryCode(rawValue: "DZ")!)
		XCTAssertEqual(textfield.defaultRegion, "DZ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AS")!)
		XCTAssertEqual(textfield.defaultRegion, "AS")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AD")!)
		XCTAssertEqual(textfield.defaultRegion, "AD")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AO")!)
		XCTAssertEqual(textfield.defaultRegion, "AO")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AI")!)
		XCTAssertEqual(textfield.defaultRegion, "AI")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AG")!)
		XCTAssertEqual(textfield.defaultRegion, "AG")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AR")!)
		XCTAssertEqual(textfield.defaultRegion, "AR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AM")!)
		XCTAssertEqual(textfield.defaultRegion, "AM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AW")!)
		XCTAssertEqual(textfield.defaultRegion, "AW")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AU")!)
		XCTAssertEqual(textfield.defaultRegion, "AU")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AT")!)
		XCTAssertEqual(textfield.defaultRegion, "AT")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AZ")!)
		XCTAssertEqual(textfield.defaultRegion, "AZ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AX")!)
		XCTAssertEqual(textfield.defaultRegion, "AX")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BS")!)
		XCTAssertEqual(textfield.defaultRegion, "BS")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BH")!)
		XCTAssertEqual(textfield.defaultRegion, "BH")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BD")!)
		XCTAssertEqual(textfield.defaultRegion, "BD")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BB")!)
		XCTAssertEqual(textfield.defaultRegion, "BB")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BY")!)
		XCTAssertEqual(textfield.defaultRegion, "BY")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BE")!)
		XCTAssertEqual(textfield.defaultRegion, "BE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BZ")!)
		XCTAssertEqual(textfield.defaultRegion, "BZ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BJ")!)
		XCTAssertEqual(textfield.defaultRegion, "BJ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BM")!)
		XCTAssertEqual(textfield.defaultRegion, "BM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BT")!)
		XCTAssertEqual(textfield.defaultRegion, "BT")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BO")!)
		XCTAssertEqual(textfield.defaultRegion, "BO")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BA")!)
		XCTAssertEqual(textfield.defaultRegion, "BA")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BW")!)
		XCTAssertEqual(textfield.defaultRegion, "BW")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BR")!)
		XCTAssertEqual(textfield.defaultRegion, "BR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "IO")!)
		XCTAssertEqual(textfield.defaultRegion, "IO")

		textfield.setFlag(for: FPNCountryCode(rawValue: "VG")!)
		XCTAssertEqual(textfield.defaultRegion, "VG")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BN")!)
		XCTAssertEqual(textfield.defaultRegion, "BN")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BG")!)
		XCTAssertEqual(textfield.defaultRegion, "BG")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BF")!)
		XCTAssertEqual(textfield.defaultRegion, "BF")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BI")!)
		XCTAssertEqual(textfield.defaultRegion, "BI")

		textfield.setFlag(for: FPNCountryCode(rawValue: "KH")!)
		XCTAssertEqual(textfield.defaultRegion, "KH")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CM")!)
		XCTAssertEqual(textfield.defaultRegion, "CM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CA")!)
		XCTAssertEqual(textfield.defaultRegion, "CA")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CV")!)
		XCTAssertEqual(textfield.defaultRegion, "CV")

		textfield.setFlag(for: FPNCountryCode(rawValue: "KY")!)
		XCTAssertEqual(textfield.defaultRegion, "KY")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CF")!)
		XCTAssertEqual(textfield.defaultRegion, "CF")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TD")!)
		XCTAssertEqual(textfield.defaultRegion, "TD")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CL")!)
		XCTAssertEqual(textfield.defaultRegion, "CL")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CN")!)
		XCTAssertEqual(textfield.defaultRegion, "CN")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CX")!)
		XCTAssertEqual(textfield.defaultRegion, "CX")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CC")!)
		XCTAssertEqual(textfield.defaultRegion, "CC")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CO")!)
		XCTAssertEqual(textfield.defaultRegion, "CO")

		textfield.setFlag(for: FPNCountryCode(rawValue: "KM")!)
		XCTAssertEqual(textfield.defaultRegion, "KM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CG")!)
		XCTAssertEqual(textfield.defaultRegion, "CG")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CD")!)
		XCTAssertEqual(textfield.defaultRegion, "CD")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CK")!)
		XCTAssertEqual(textfield.defaultRegion, "CK")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CR")!)
		XCTAssertEqual(textfield.defaultRegion, "CR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CI")!)
		XCTAssertEqual(textfield.defaultRegion, "CI")

		textfield.setFlag(for: FPNCountryCode(rawValue: "HR")!)
		XCTAssertEqual(textfield.defaultRegion, "HR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CU")!)
		XCTAssertEqual(textfield.defaultRegion, "CU")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CY")!)
		XCTAssertEqual(textfield.defaultRegion, "CY")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CZ")!)
		XCTAssertEqual(textfield.defaultRegion, "CZ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "DK")!)
		XCTAssertEqual(textfield.defaultRegion, "DK")

		textfield.setFlag(for: FPNCountryCode(rawValue: "DJ")!)
		XCTAssertEqual(textfield.defaultRegion, "DJ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "DM")!)
		XCTAssertEqual(textfield.defaultRegion, "DM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "DO")!)
		XCTAssertEqual(textfield.defaultRegion, "DO")

		textfield.setFlag(for: FPNCountryCode(rawValue: "EC")!)
		XCTAssertEqual(textfield.defaultRegion, "EC")

		textfield.setFlag(for: FPNCountryCode(rawValue: "EG")!)
		XCTAssertEqual(textfield.defaultRegion, "EG")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SV")!)
		XCTAssertEqual(textfield.defaultRegion, "SV")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GQ")!)
		XCTAssertEqual(textfield.defaultRegion, "GQ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "ER")!)
		XCTAssertEqual(textfield.defaultRegion, "ER")

		textfield.setFlag(for: FPNCountryCode(rawValue: "EE")!)
		XCTAssertEqual(textfield.defaultRegion, "EE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "ET")!)
		XCTAssertEqual(textfield.defaultRegion, "ET")

		textfield.setFlag(for: FPNCountryCode(rawValue: "FK")!)
		XCTAssertEqual(textfield.defaultRegion, "FK")

		textfield.setFlag(for: FPNCountryCode(rawValue: "FO")!)
		XCTAssertEqual(textfield.defaultRegion, "FO")

		textfield.setFlag(for: FPNCountryCode(rawValue: "FJ")!)
		XCTAssertEqual(textfield.defaultRegion, "FJ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "FI")!)
		XCTAssertEqual(textfield.defaultRegion, "FI")

		textfield.setFlag(for: FPNCountryCode(rawValue: "FR")!)
		XCTAssertEqual(textfield.defaultRegion, "FR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GF")!)
		XCTAssertEqual(textfield.defaultRegion, "GF")

		textfield.setFlag(for: FPNCountryCode(rawValue: "PF")!)
		XCTAssertEqual(textfield.defaultRegion, "PF")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GA")!)
		XCTAssertEqual(textfield.defaultRegion, "GA")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GM")!)
		XCTAssertEqual(textfield.defaultRegion, "GM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GE")!)
		XCTAssertEqual(textfield.defaultRegion, "GE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "DE")!)
		XCTAssertEqual(textfield.defaultRegion, "DE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GH")!)
		XCTAssertEqual(textfield.defaultRegion, "GH")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GI")!)
		XCTAssertEqual(textfield.defaultRegion, "GI")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GR")!)
		XCTAssertEqual(textfield.defaultRegion, "GR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GL")!)
		XCTAssertEqual(textfield.defaultRegion, "GL")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GD")!)
		XCTAssertEqual(textfield.defaultRegion, "GD")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GP")!)
		XCTAssertEqual(textfield.defaultRegion, "GP")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GU")!)
		XCTAssertEqual(textfield.defaultRegion, "GU")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GT")!)
		XCTAssertEqual(textfield.defaultRegion, "GT")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GG")!)
		XCTAssertEqual(textfield.defaultRegion, "GG")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GN")!)
		XCTAssertEqual(textfield.defaultRegion, "GN")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GW")!)
		XCTAssertEqual(textfield.defaultRegion, "GW")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GY")!)
		XCTAssertEqual(textfield.defaultRegion, "GY")

		textfield.setFlag(for: FPNCountryCode(rawValue: "HT")!)
		XCTAssertEqual(textfield.defaultRegion, "HT")

		textfield.setFlag(for: FPNCountryCode(rawValue: "HN")!)
		XCTAssertEqual(textfield.defaultRegion, "HN")

		textfield.setFlag(for: FPNCountryCode(rawValue: "HK")!)
		XCTAssertEqual(textfield.defaultRegion, "HK")

		textfield.setFlag(for: FPNCountryCode(rawValue: "HU")!)
		XCTAssertEqual(textfield.defaultRegion, "HU")

		textfield.setFlag(for: FPNCountryCode(rawValue: "IS")!)
		XCTAssertEqual(textfield.defaultRegion, "IS")

		textfield.setFlag(for: FPNCountryCode(rawValue: "IN")!)
		XCTAssertEqual(textfield.defaultRegion, "IN")

		textfield.setFlag(for: FPNCountryCode(rawValue: "ID")!)
		XCTAssertEqual(textfield.defaultRegion, "ID")

		textfield.setFlag(for: FPNCountryCode(rawValue: "IR")!)
		XCTAssertEqual(textfield.defaultRegion, "IR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "IQ")!)
		XCTAssertEqual(textfield.defaultRegion, "IQ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "IE")!)
		XCTAssertEqual(textfield.defaultRegion, "IE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "IM")!)
		XCTAssertEqual(textfield.defaultRegion, "IM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "IL")!)
		XCTAssertEqual(textfield.defaultRegion, "IL")

		textfield.setFlag(for: FPNCountryCode(rawValue: "IT")!)
		XCTAssertEqual(textfield.defaultRegion, "IT")

		textfield.setFlag(for: FPNCountryCode(rawValue: "JM")!)
		XCTAssertEqual(textfield.defaultRegion, "JM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "JP")!)
		XCTAssertEqual(textfield.defaultRegion, "JP")

		textfield.setFlag(for: FPNCountryCode(rawValue: "JE")!)
		XCTAssertEqual(textfield.defaultRegion, "JE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "JO")!)
		XCTAssertEqual(textfield.defaultRegion, "JO")

		textfield.setFlag(for: FPNCountryCode(rawValue: "KZ")!)
		XCTAssertEqual(textfield.defaultRegion, "KZ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "KE")!)
		XCTAssertEqual(textfield.defaultRegion, "KE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "KI")!)
		XCTAssertEqual(textfield.defaultRegion, "KI")

		textfield.setFlag(for: FPNCountryCode(rawValue: "KW")!)
		XCTAssertEqual(textfield.defaultRegion, "KW")

		textfield.setFlag(for: FPNCountryCode(rawValue: "KG")!)
		XCTAssertEqual(textfield.defaultRegion, "KG")

		textfield.setFlag(for: FPNCountryCode(rawValue: "LA")!)
		XCTAssertEqual(textfield.defaultRegion, "LA")

		textfield.setFlag(for: FPNCountryCode(rawValue: "LV")!)
		XCTAssertEqual(textfield.defaultRegion, "LV")

		textfield.setFlag(for: FPNCountryCode(rawValue: "LB")!)
		XCTAssertEqual(textfield.defaultRegion, "LB")

		textfield.setFlag(for: FPNCountryCode(rawValue: "LS")!)
		XCTAssertEqual(textfield.defaultRegion, "LS")

		textfield.setFlag(for: FPNCountryCode(rawValue: "LR")!)
		XCTAssertEqual(textfield.defaultRegion, "LR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "LY")!)
		XCTAssertEqual(textfield.defaultRegion, "LY")

		textfield.setFlag(for: FPNCountryCode(rawValue: "LI")!)
		XCTAssertEqual(textfield.defaultRegion, "LI")

		textfield.setFlag(for: FPNCountryCode(rawValue: "LT")!)
		XCTAssertEqual(textfield.defaultRegion, "LT")

		textfield.setFlag(for: FPNCountryCode(rawValue: "LU")!)
		XCTAssertEqual(textfield.defaultRegion, "LU")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MO")!)
		XCTAssertEqual(textfield.defaultRegion, "MO")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MK")!)
		XCTAssertEqual(textfield.defaultRegion, "MK")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MG")!)
		XCTAssertEqual(textfield.defaultRegion, "MG")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MW")!)
		XCTAssertEqual(textfield.defaultRegion, "MW")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MY")!)
		XCTAssertEqual(textfield.defaultRegion, "MY")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MV")!)
		XCTAssertEqual(textfield.defaultRegion, "MV")

		textfield.setFlag(for: FPNCountryCode(rawValue: "ML")!)
		XCTAssertEqual(textfield.defaultRegion, "ML")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MT")!)
		XCTAssertEqual(textfield.defaultRegion, "MT")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MH")!)
		XCTAssertEqual(textfield.defaultRegion, "MH")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MQ")!)
		XCTAssertEqual(textfield.defaultRegion, "MQ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MR")!)
		XCTAssertEqual(textfield.defaultRegion, "MR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MU")!)
		XCTAssertEqual(textfield.defaultRegion, "MU")

		textfield.setFlag(for: FPNCountryCode(rawValue: "YT")!)
		XCTAssertEqual(textfield.defaultRegion, "YT")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MX")!)
		XCTAssertEqual(textfield.defaultRegion, "MX")

		textfield.setFlag(for: FPNCountryCode(rawValue: "FM")!)
		XCTAssertEqual(textfield.defaultRegion, "FM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MD")!)
		XCTAssertEqual(textfield.defaultRegion, "MD")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MC")!)
		XCTAssertEqual(textfield.defaultRegion, "MC")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MN")!)
		XCTAssertEqual(textfield.defaultRegion, "MN")

		textfield.setFlag(for: FPNCountryCode(rawValue: "ME")!)
		XCTAssertEqual(textfield.defaultRegion, "ME")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MS")!)
		XCTAssertEqual(textfield.defaultRegion, "MS")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MA")!)
		XCTAssertEqual(textfield.defaultRegion, "MA")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MZ")!)
		XCTAssertEqual(textfield.defaultRegion, "MZ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MM")!)
		XCTAssertEqual(textfield.defaultRegion, "MM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "NA")!)
		XCTAssertEqual(textfield.defaultRegion, "NA")

		textfield.setFlag(for: FPNCountryCode(rawValue: "NR")!)
		XCTAssertEqual(textfield.defaultRegion, "NR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "NP")!)
		XCTAssertEqual(textfield.defaultRegion, "NP")

		textfield.setFlag(for: FPNCountryCode(rawValue: "NL")!)
		XCTAssertEqual(textfield.defaultRegion, "NL")

		textfield.setFlag(for: FPNCountryCode(rawValue: "NC")!)
		XCTAssertEqual(textfield.defaultRegion, "NC")

		textfield.setFlag(for: FPNCountryCode(rawValue: "NZ")!)
		XCTAssertEqual(textfield.defaultRegion, "NZ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "NI")!)
		XCTAssertEqual(textfield.defaultRegion, "NI")

		textfield.setFlag(for: FPNCountryCode(rawValue: "NE")!)
		XCTAssertEqual(textfield.defaultRegion, "NE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "NG")!)
		XCTAssertEqual(textfield.defaultRegion, "NG")

		textfield.setFlag(for: FPNCountryCode(rawValue: "NU")!)
		XCTAssertEqual(textfield.defaultRegion, "NU")

		textfield.setFlag(for: FPNCountryCode(rawValue: "NF")!)
		XCTAssertEqual(textfield.defaultRegion, "NF")

		textfield.setFlag(for: FPNCountryCode(rawValue: "KP")!)
		XCTAssertEqual(textfield.defaultRegion, "KP")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MP")!)
		XCTAssertEqual(textfield.defaultRegion, "MP")

		textfield.setFlag(for: FPNCountryCode(rawValue: "NO")!)
		XCTAssertEqual(textfield.defaultRegion, "NO")

		textfield.setFlag(for: FPNCountryCode(rawValue: "OM")!)
		XCTAssertEqual(textfield.defaultRegion, "OM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "PK")!)
		XCTAssertEqual(textfield.defaultRegion, "PK")

		textfield.setFlag(for: FPNCountryCode(rawValue: "PW")!)
		XCTAssertEqual(textfield.defaultRegion, "PW")

		textfield.setFlag(for: FPNCountryCode(rawValue: "PS")!)
		XCTAssertEqual(textfield.defaultRegion, "PS")

		textfield.setFlag(for: FPNCountryCode(rawValue: "PA")!)
		XCTAssertEqual(textfield.defaultRegion, "PA")

		textfield.setFlag(for: FPNCountryCode(rawValue: "PG")!)
		XCTAssertEqual(textfield.defaultRegion, "PG")

		textfield.setFlag(for: FPNCountryCode(rawValue: "PY")!)
		XCTAssertEqual(textfield.defaultRegion, "PY")

		textfield.setFlag(for: FPNCountryCode(rawValue: "PE")!)
		XCTAssertEqual(textfield.defaultRegion, "PE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "PH")!)
		XCTAssertEqual(textfield.defaultRegion, "PH")

		textfield.setFlag(for: FPNCountryCode(rawValue: "PL")!)
		XCTAssertEqual(textfield.defaultRegion, "PL")

		textfield.setFlag(for: FPNCountryCode(rawValue: "PT")!)
		XCTAssertEqual(textfield.defaultRegion, "PT")

		textfield.setFlag(for: FPNCountryCode(rawValue: "PR")!)
		XCTAssertEqual(textfield.defaultRegion, "PR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "QA")!)
		XCTAssertEqual(textfield.defaultRegion, "QA")

		textfield.setFlag(for: FPNCountryCode(rawValue: "RE")!)
		XCTAssertEqual(textfield.defaultRegion, "RE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "RO")!)
		XCTAssertEqual(textfield.defaultRegion, "RO")

		textfield.setFlag(for: FPNCountryCode(rawValue: "RU")!)
		XCTAssertEqual(textfield.defaultRegion, "RU")

		textfield.setFlag(for: FPNCountryCode(rawValue: "RW")!)
		XCTAssertEqual(textfield.defaultRegion, "RW")

		textfield.setFlag(for: FPNCountryCode(rawValue: "WS")!)
		XCTAssertEqual(textfield.defaultRegion, "WS")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SM")!)
		XCTAssertEqual(textfield.defaultRegion, "SM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SA")!)
		XCTAssertEqual(textfield.defaultRegion, "SA")

		textfield.setFlag(for: FPNCountryCode(rawValue: "ST")!)
		XCTAssertEqual(textfield.defaultRegion, "ST")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SN")!)
		XCTAssertEqual(textfield.defaultRegion, "SN")

		textfield.setFlag(for: FPNCountryCode(rawValue: "RS")!)
		XCTAssertEqual(textfield.defaultRegion, "RS")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SC")!)
		XCTAssertEqual(textfield.defaultRegion, "SC")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SL")!)
		XCTAssertEqual(textfield.defaultRegion, "SL")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SG")!)
		XCTAssertEqual(textfield.defaultRegion, "SG")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SK")!)
		XCTAssertEqual(textfield.defaultRegion, "SK")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SI")!)
		XCTAssertEqual(textfield.defaultRegion, "SI")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SB")!)
		XCTAssertEqual(textfield.defaultRegion, "SB")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SO")!)
		XCTAssertEqual(textfield.defaultRegion, "SO")

		textfield.setFlag(for: FPNCountryCode(rawValue: "ZA")!)
		XCTAssertEqual(textfield.defaultRegion, "ZA")

		textfield.setFlag(for: FPNCountryCode(rawValue: "KR")!)
		XCTAssertEqual(textfield.defaultRegion, "KR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SS")!)
		XCTAssertEqual(textfield.defaultRegion, "SS")

		textfield.setFlag(for: FPNCountryCode(rawValue: "ES")!)
		XCTAssertEqual(textfield.defaultRegion, "ES")

		textfield.setFlag(for: FPNCountryCode(rawValue: "LK")!)
		XCTAssertEqual(textfield.defaultRegion, "LK")

		textfield.setFlag(for: FPNCountryCode(rawValue: "BL")!)
		XCTAssertEqual(textfield.defaultRegion, "BL")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SH")!)
		XCTAssertEqual(textfield.defaultRegion, "SH")

		textfield.setFlag(for: FPNCountryCode(rawValue: "KN")!)
		XCTAssertEqual(textfield.defaultRegion, "KN")

		textfield.setFlag(for: FPNCountryCode(rawValue: "LC")!)
		XCTAssertEqual(textfield.defaultRegion, "LC")

		textfield.setFlag(for: FPNCountryCode(rawValue: "MF")!)
		XCTAssertEqual(textfield.defaultRegion, "MF")

		textfield.setFlag(for: FPNCountryCode(rawValue: "PM")!)
		XCTAssertEqual(textfield.defaultRegion, "PM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "VC")!)
		XCTAssertEqual(textfield.defaultRegion, "VC")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SD")!)
		XCTAssertEqual(textfield.defaultRegion, "SD")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SR")!)
		XCTAssertEqual(textfield.defaultRegion, "SR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SJ")!)
		XCTAssertEqual(textfield.defaultRegion, "SJ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SZ")!)
		XCTAssertEqual(textfield.defaultRegion, "SZ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SE")!)
		XCTAssertEqual(textfield.defaultRegion, "SE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "CH")!)
		XCTAssertEqual(textfield.defaultRegion, "CH")

		textfield.setFlag(for: FPNCountryCode(rawValue: "SY")!)
		XCTAssertEqual(textfield.defaultRegion, "SY")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TW")!)
		XCTAssertEqual(textfield.defaultRegion, "TW")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TJ")!)
		XCTAssertEqual(textfield.defaultRegion, "TJ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TZ")!)
		XCTAssertEqual(textfield.defaultRegion, "TZ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TH")!)
		XCTAssertEqual(textfield.defaultRegion, "TH")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TL")!)
		XCTAssertEqual(textfield.defaultRegion, "TL")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TG")!)
		XCTAssertEqual(textfield.defaultRegion, "TG")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TK")!)
		XCTAssertEqual(textfield.defaultRegion, "TK")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TO")!)
		XCTAssertEqual(textfield.defaultRegion, "TO")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TT")!)
		XCTAssertEqual(textfield.defaultRegion, "TT")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TN")!)
		XCTAssertEqual(textfield.defaultRegion, "TN")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TR")!)
		XCTAssertEqual(textfield.defaultRegion, "TR")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TM")!)
		XCTAssertEqual(textfield.defaultRegion, "TM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TC")!)
		XCTAssertEqual(textfield.defaultRegion, "TC")

		textfield.setFlag(for: FPNCountryCode(rawValue: "TV")!)
		XCTAssertEqual(textfield.defaultRegion, "TV")

		textfield.setFlag(for: FPNCountryCode(rawValue: "VI")!)
		XCTAssertEqual(textfield.defaultRegion, "VI")

		textfield.setFlag(for: FPNCountryCode(rawValue: "UG")!)
		XCTAssertEqual(textfield.defaultRegion, "UG")

		textfield.setFlag(for: FPNCountryCode(rawValue: "UA")!)
		XCTAssertEqual(textfield.defaultRegion, "UA")

		textfield.setFlag(for: FPNCountryCode(rawValue: "AE")!)
		XCTAssertEqual(textfield.defaultRegion, "AE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "GB")!)
		XCTAssertEqual(textfield.defaultRegion, "GB")

		textfield.setFlag(for: FPNCountryCode(rawValue: "US")!)
		XCTAssertEqual(textfield.defaultRegion, "US")

		textfield.setFlag(for: FPNCountryCode(rawValue: "UY")!)
		XCTAssertEqual(textfield.defaultRegion, "UY")

		textfield.setFlag(for: FPNCountryCode(rawValue: "UZ")!)
		XCTAssertEqual(textfield.defaultRegion, "UZ")

		textfield.setFlag(for: FPNCountryCode(rawValue: "VU")!)
		XCTAssertEqual(textfield.defaultRegion, "VU")

		textfield.setFlag(for: FPNCountryCode(rawValue: "VA")!)
		XCTAssertEqual(textfield.defaultRegion, "VA")

		textfield.setFlag(for: FPNCountryCode(rawValue: "VE")!)
		XCTAssertEqual(textfield.defaultRegion, "VE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "VN")!)
		XCTAssertEqual(textfield.defaultRegion, "VN")

		textfield.setFlag(for: FPNCountryCode(rawValue: "WF")!)
		XCTAssertEqual(textfield.defaultRegion, "WF")

		textfield.setFlag(for: FPNCountryCode(rawValue: "YE")!)
		XCTAssertEqual(textfield.defaultRegion, "YE")

		textfield.setFlag(for: FPNCountryCode(rawValue: "ZM")!)
		XCTAssertEqual(textfield.defaultRegion, "ZM")

		textfield.setFlag(for: FPNCountryCode(rawValue: "ZW")!)
		XCTAssertEqual(textfield.defaultRegion, "ZW")
	}
}
