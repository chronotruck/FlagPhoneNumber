//
//  TableViewController.swift
//  FlagPhoneNumber_Example
//
//  Created by Aurelien on 24/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class TableViewController: UITableViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "In Table View"
		tableView.delaysContentTouches = false
	}
}
