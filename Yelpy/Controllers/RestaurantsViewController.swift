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
    
    
    // –––––– TODO: Initialize restaurantsArray
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var restaurantsArray: [Restaurant] = []
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getAPIData()
    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData(){
        API.getRestaurants() {(restaurants) in guard let restaurants = restaurants else{
            return
        }
        print(restaurants)
        self.restaurantsArray = restaurants
        self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        let restaurant = restaurantsArray[indexPath.row]
        
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
        cell.r = restaurant
        
        return cell
    }

// ––––– TODO: Create tableView Extension and TableView Functionality

}
