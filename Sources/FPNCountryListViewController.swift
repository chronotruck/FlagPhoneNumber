//
//  FPNCountryListViewController.swift
//  FlagPhoneNumber
//
//  Created by Aurélien Grifasi on 06/08/2017.
//  Copyright (c) 2017 Aurélien Grifasi. All rights reserved.
//

import UIKit

open class FPNCountryListViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate {

	var countries: [FPNCountry]
	var showCountryPhoneCode: Bool

	var searchController: UISearchController?
	var results: [FPNCountry]?

	public var didSelect: ((FPNCountry) -> Void)?

	public init(countries: [FPNCountry], showCountryPhoneCode: Bool = true) {
		self.countries = countries
		self.showCountryPhoneCode = showCountryPhoneCode

		super.init(nibName: nil, bundle: nil)
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override open func viewDidLoad() {
		super.viewDidLoad()

		tableView.tableFooterView = UIView()
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissController))

		initSearchBarController()
	}

	@objc private func dismissController() {
		dismiss(animated: true, completion: nil)
	}

	private func initSearchBarController() {
		searchController = UISearchController(searchResultsController: nil)
		searchController?.searchResultsUpdater = self
		searchController?.delegate = self

		if #available(iOS 9.1, *) {
			searchController?.obscuresBackgroundDuringPresentation = false
		} else {
			// Fallback on earlier versions
		}

		if #available(iOS 11.0, *) {
			navigationItem.searchController = searchController
			navigationItem.hidesSearchBarWhenScrolling = false
		} else {
			searchController?.dimsBackgroundDuringPresentation = false
			searchController?.hidesNavigationBarDuringPresentation = true
			searchController?.definesPresentationContext = true

			//				searchController?.searchBar.sizeToFit()
			tableView.tableHeaderView = searchController?.searchBar
		}
		definesPresentationContext = true
	}

	private func getItem(at indexPath: IndexPath) -> FPNCountry {
		var array: [FPNCountry]!

		if let searchController = searchController, searchController.isActive && results != nil && results!.count > 0 {
			array = results
		} else {
			array = countries
		}

		return array[indexPath.row]
	}

	override open func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let searchController = searchController, searchController.isActive {
			if let count = searchController.searchBar.text?.count, count > 0 {
				return results?.count ?? 0
			}
		}
		return countries.count
	}

	override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
		let country = getItem(at: indexPath)

		cell.imageView?.image = country.flag
		cell.textLabel?.text = country.name

		if showCountryPhoneCode {
			cell.detailTextLabel?.text = country.phoneCode
		}

		return cell
	}

	override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let country = getItem(at: indexPath)

		tableView.deselectRow(at: indexPath, animated: true)

		didSelect?(country)

		searchController?.isActive = false
		searchController?.searchBar.resignFirstResponder()
		dismissController()
	}

	// UISearchResultsUpdating

	public func updateSearchResults(for searchController: UISearchController) {
		if countries.isEmpty {
			results?.removeAll()
			return
		} else if searchController.searchBar.text == "" {
			results?.removeAll()
			tableView.reloadData()
			return
		}

		if let searchText = searchController.searchBar.text, searchText.count > 0 {
			results = countries.filter({(item: FPNCountry) -> Bool in
				if item.name.lowercased().range(of: searchText.lowercased()) != nil {
					return true
				} else if item.code.rawValue.lowercased().range(of: searchText.lowercased()) != nil {
					return true
				} else if item.phoneCode.lowercased().range(of: searchText.lowercased()) != nil {
					return true
				}
				return false
			})
		}
		tableView.reloadData()
	}

	// UISearchControllerDelegate

	public func willDismissSearchController(_ searchController: UISearchController) {
		results?.removeAll()
	}
}
