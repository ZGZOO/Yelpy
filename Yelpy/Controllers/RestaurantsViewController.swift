//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    
    // ––––– TODO: Next, place TableView outlet here
    @IBOutlet weak var tableView: UITableView!
    
    // –––––– TODO: Initialize restaurantsArray
    var restaurantsArray: [Restaurant] = []
    
    // ––––– TODO: Add Search Bar Outlet + Variable for filtered Results
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredRestaurants: [Restaurant] = []
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View
        tableView.delegate = self
        tableView.dataSource = self
        
        // Search Bar delegate
        searchBar.delegate = self
        
        // Get Data from API
        getAPIData()
    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData(){
        API.getRestaurants() {(restaurants) in guard let restaurants = restaurants else{
            return
        }
        print(restaurants)
        self.restaurantsArray = restaurants
        self.filteredRestaurants = restaurants
        self.tableView.reloadData()
        }
    }
}

// ––––– TODO: Create tableView Extension and TableView Functionality
// ––––– TODO: Pass restaurant to details view controller through segue
extension RestaurantsViewController {
    // ––––– TableView Functionality –––––
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        cell.r = filteredRestaurants[indexPath.row]
        return cell
    
//        // name and phone
//        cell.nameLabel.text = restaurant["name"] as? String
//        cell.phoneLabel.text = restaurant["display_phone"] as? String
//
//        // reviews
//        let reviews = restaurant["review_count"] as? Int
//        cell.reviewsLabel.text = String(reviews!)
//
//        // Get categories
//        let categories = restaurant["categories"] as! [[String: Any]]
//        cell.categoryLabel.text = categories[0]["title"] as? String
//
//        // Set stars images
//        let reviewDouble = restaurant["rating"] as! Double
//        cell.starsImage.image = Stars.dict[reviewDouble]!
//
//        // food image
//        if let imageUrlString = restaurant["image_url"] as? String {
//            let imageUrl = URL(string: imageUrlString)
//            cell.restautantImage.af.setImage(withURL: imageUrl!)
//        }
    }
    
    // ––––– Pass restaurant to details view controller through segue –––––
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let r = filteredRestaurants[indexPath.row]
            let detailViewController = segue.destination as! RestaurantDetailViewController
            detailViewController.r = r
        }
    }
}

// ––––– TODO: Add protocol + Functionality for Searching
// UISearchResultsUpdating informs the class of text changes
// happening in the UISearchBar
extension RestaurantsViewController: UISearchBarDelegate {
    // Search bar functionality
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredRestaurants = restaurantsArray.filter { (r: Restaurant) -> Bool in
              return r.name.lowercased().contains(searchText.lowercased())
            }
        }
        else {
            filteredRestaurants = restaurantsArray
        }
        tableView.reloadData()
    }

    // Show Cancel button when typing
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       self.searchBar.showsCancelButton = true
    }
       
    // Logic for searchBar cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchBar.showsCancelButton = false // remove cancel button
       searchBar.text = "" // reset search text
       searchBar.resignFirstResponder() // remove keyboard
       filteredRestaurants = restaurantsArray // reset results to display
       tableView.reloadData()
    }
}




