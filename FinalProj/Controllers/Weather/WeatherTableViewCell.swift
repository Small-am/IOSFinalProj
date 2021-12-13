//
//  WeatherTableViewCell.swift
//  FinalProj
//
//  Created by MacOS on 2021-12-11.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet var temp : UILabel!
    @IBOutlet var city : UILabel!
    @IBOutlet var location : UILabel!
    @IBOutlet var img : UIImageView!
    @IBOutlet var btn : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
