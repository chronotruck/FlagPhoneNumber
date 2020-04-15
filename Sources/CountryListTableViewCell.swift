//
//  CountryListTableViewCell.swift
//  FlagPhoneNumber
//
//  Created by Ahmed Allam on 4/15/20.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {

    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setup(_ country: FPNCountry, showPhoneCode: Bool) {
        flagLabel.text = country.flag
        countryNameLabel.text = country.name
        if showPhoneCode{
            countryCodeLabel.text = country.phoneCode
        }
    }
}
