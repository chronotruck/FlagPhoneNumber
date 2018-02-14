import Foundation

class NibLoadingView: UIView {
	
	@IBOutlet weak var view: UIView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		nibSetup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		nibSetup()
	}
	
	fileprivate func nibSetup() {
		backgroundColor = UIColor.clear
		
		view = loadViewFromNib()
		view.frame = bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		view.translatesAutoresizingMaskIntoConstraints = true
		
		addSubview(view)
	}
	
	fileprivate func loadViewFromNib() -> UIView {
		let bundle = Bundle.CTKFlagPhoneNumber()
		let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
		let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
		
		return nibView
	}
}

class CountryView: NibLoadingView {
	
	@IBOutlet weak var flagImageView: UIImageView!
	@IBOutlet weak var countryNameLabel: UILabel!
	@IBOutlet weak var countryCodeLabel: UILabel!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func setup(_ country: Country) {		
		flagImageView.image = country.flag
		countryCodeLabel.text = country.phoneCode
		countryNameLabel.text = country.name
	}
}
