//
//  EventTableViewCell.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-11-01.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var textV: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
