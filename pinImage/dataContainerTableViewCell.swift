//
//  dataContainerTableViewCell.swift
//  pinImage
//
//  Created by Nikhil on 1/14/19.
//  Copyright © 2019 Nikhil. All rights reserved.
//

import UIKit

class dataContainerTableViewCell: UITableViewCell {
    @IBOutlet weak var containerImage: UIImageView!
    @IBOutlet weak var containerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
