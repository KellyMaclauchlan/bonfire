//
//  ChatTableViewCell.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-11-24.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var names: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
