//
//  ScrollViewController.swift
//  FlagPhoneNumber_Example
//
//  Created by Aurelien on 26/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var contentView: UIView!

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "In Scroll View"
		contentView.backgroundColor = UIColor.groupTableViewBackground
		scrollView.delaysContentTouches = false
	}
}
