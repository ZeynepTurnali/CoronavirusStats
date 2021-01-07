//
//  WorldViewController.swift

import UIKit
import Alamofire
import SwiftyJSON


class WorldViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    let countryNamesUrl = URL(string: "https://api.covid19api.com/countries")!
    
    var filteredArray = [String]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    var countryNamesArray = [String]()
    var selectedCountry : String = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.tintColor = UIColor(red: 0.85, green: 0.12, blue: 0.22, alpha: 1.00)
        self.tableView.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.00)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadListOfCountries()
        configureSearchController()
        
        
        searchBar.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("will disappear")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return countryNamesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryNameCell", for: indexPath)
        cell.backgroundColor = UIColor.white
        
        if shouldShowSearchResults {
            cell.textLabel?.text = filteredArray[indexPath.row]
        }
        else {
            cell.textLabel?.text = countryNamesArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCountry = filteredArray[indexPath.row]
        print(selectedCountry)
        
        self.performSegue(withIdentifier: "worldDataShowDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "worldDataShowDetail" {
            let worldWeatherDetail = segue.destination as! WorldDataDetailViewController
            worldWeatherDetail.chosenCountry = selectedCountry
        }
    }
    

    

    
    func loadListOfCountries(){
        let request = AF.request(countryNamesUrl).validate()
        request.responseJSON { (data) in
            // print(data)
        }
        
        request.responseDecodable(of: [CountryListModel].self) { (response) in
            guard let models = response.value else { return }
            
            for model in models {
                self.countryNamesArray.append(model.country)
                self.shouldShowSearchResults = true
            }
            
        }
        if self.shouldShowSearchResults {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a country..."
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    public func updateSearchResults(for searchController: UISearchController){
        let searchString = searchController.searchBar.text
        
        filteredArray = countryNamesArray.filter({ (country) -> Bool in
            let countryText: NSString = country as NSString
            return (countryText.range(of: searchString!, options: .caseInsensitive).location) != NSNotFound
        })
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }





}
