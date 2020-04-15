import UIKit

class FPNCountryView: NibLoadingView {

	@IBOutlet weak var flagLabel: UILabel!
	@IBOutlet weak var countryNameLabel: UILabel!
	@IBOutlet weak var countryCodeLabel: UILabel!

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	func setup(_ country: FPNCountry) {
		flagLabel.text = country.flag
		countryCodeLabel.text = country.phoneCode
		countryNameLabel.text = country.name
	}
}
