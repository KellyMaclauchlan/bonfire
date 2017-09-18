//
//  ItemTableViewCell.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-10-27.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
