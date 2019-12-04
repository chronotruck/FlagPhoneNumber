//
//  FPNFormat.swift
//  FlagPhoneNumber
//
//  Created by Aurélien Grifasi on 06/08/2017.
//  Copyright (c) 2017 Aurélien Grifasi. All rights reserved.
//

import Foundation

@objc public enum FPNFormat: Int {
	case E164
	case International
	case National
	case RFC3966
}
