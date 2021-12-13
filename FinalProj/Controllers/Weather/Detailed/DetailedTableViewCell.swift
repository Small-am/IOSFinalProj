//
//  DetailedTableViewCell.swift
//  FinalProj
//
//  Created by MacOS on 2021-12-11.
//

import UIKit

class DetailedTableViewCell: UITableViewCell {

    @IBOutlet var time : UILabel!
    @IBOutlet var temp : UILabel!
    @IBOutlet var img : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
