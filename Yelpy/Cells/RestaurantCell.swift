//
//  RestaurantCell.swift
//  Yelpy
//
//  Created by Zhijie (Jenny) Xu on 8/28/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var restautantImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var starsImage: UIImageView!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    // Add Movie Variable + didset
    // in the controller, a var (as type of Restaurant) will be set to be this r!
    var r: Restaurant! {
        didSet {
            nameLabel.text = r.name
            categoryLabel.text = r.mainCategory
            phoneLabel.text = r.phone
            reviewsLabel.text = String(r.reviews) + " reviews"
            
            // set images
            starsImage.image = Stars.dict[r.rating]!
            restautantImage.af.setImage(withURL: r.imageURL!)
            restautantImage.layer.cornerRadius = 10
            restautantImage.clipsToBounds = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
