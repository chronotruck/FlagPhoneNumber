//                                                                  _______________________________________________
//                                                                 |                                               | |\
//                                                                 |                                               | ||
//  ____ _                           _                   _         |                                               |,""---:___
// / ___| |__  _ __ ___  _ __   ___ | |_ _ _  _   _  ___| | __     |                                               ||==  | .-.|
// | |  | '_ \| '_// _ \| '_ \ / _ \| __| '_/| | | |/ __| |/ /     |                                               ||==  | '-'-----.
// | |__| | | | | | (_) | | | | (_) | |_| |  | |_| | (__|   <      |_______________________________________________||    |~  |   -(|
// \____|_| |_|_|  \___/|_| |_|\___/ \__|_|   \__,_|\___|_|\_\     |_____________________________/<  _...==...____|    |   | ___ |
//                                                                  \\ .-.  .-. //            \|  \//.-.  .-.\\ --------"-"/.-.\_]
//                                                                  ` ( o )( o )'              '    ( o )( o )`"""""""""==`( o )
//                                                                     '-'  '-'                      '-'  '-'               '-'

//  Created by Aurélien GRIFASI on 07/06/2017.


import Foundation

class CTKSearchCountryViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate {
	
	var searchController: UISearchController?
	var list: [Country]?
	var results: [Country]?
	
	var delegate: CTKFlagPhoneNumberDelegate?
	
	
	init(countries: [Country]) {
		super.init(nibName: nil, bundle: nil)
		
		self.list = countries
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initSearchBarController()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		if #available(iOS 11.0, *) {
			navigationItem.hidesSearchBarWhenScrolling = false
		} else {
			// Fallback on earlier versions
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		searchController?.isActive = true
	}
	
	@objc private func dismissController() {
		dismiss(animated: false, completion: nil)
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
		} else {
			searchController?.dimsBackgroundDuringPresentation = false
			searchController?.hidesNavigationBarDuringPresentation = true
			searchController?.definesPresentationContext = true
			
			//				searchController?.searchBar.sizeToFit()
			tableView.tableHeaderView = searchController?.searchBar
		}
		definesPresentationContext = true
	}
	
	private func getItem(at indexPath: IndexPath) -> Country {
		var array: [Country]!
		
		if let searchController = searchController, searchController.isActive && results != nil && results!.count > 0 {
			array = results
		} else {
			array = list
		}
		
		return array[indexPath.row]
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let searchController = searchController, searchController.isActive {
			if let count = searchController.searchBar.text?.count, count > 0 {
				return results?.count ?? 0
			}
		}
		return list?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
		let country = getItem(at: indexPath)
		
		cell.textLabel?.text = country.name
		cell.detailTextLabel?.text = country.phoneCode
		cell.imageView?.image = country.flag
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.reloadRows(at: [indexPath], with: .automatic)
		
		delegate?.didSelect(country: getItem(at: indexPath))
		
		searchController?.isActive = false
		searchController?.searchBar.resignFirstResponder()
		
		dismissController()
	}

	// UISearchResultsUpdating
	
	func updateSearchResults(for searchController: UISearchController) {
		if list == nil {
			results?.removeAll()
			return
		} else if searchController.searchBar.text == "" {
			results?.removeAll()
			tableView.reloadData()
			return
		}
		
		if let searchText = searchController.searchBar.text, searchText.count > 0 {
			results = list!.filter({(item: Country) -> Bool in
				if item.name?.lowercased().range(of: searchText.lowercased()) != nil {
					return true
				} else if item.code?.lowercased().range(of: searchText.lowercased()) != nil {
					return true
				} else if item.phoneCode?.lowercased().range(of: searchText.lowercased()) != nil {
					return true
				}
				return false
			})
		}
		tableView.reloadData()
	}

	// UISearchControllerDelegate
	
	func didPresentSearchController(_ searchController: UISearchController) {
		DispatchQueue.main.async { [unowned self] in
			self.searchController?.searchBar.becomeFirstResponder()
		}
	}
	
	func willDismissSearchController(_ searchController: UISearchController) {
		results?.removeAll()
	}
	
	func didDismissSearchController(_ searchController: UISearchController) {
		dismissController()
	}
}
