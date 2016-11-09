//
//  CustomTableViewCell.swift
//  gotrader
//
//  Created by Sydna Agnehs on 2016-10-18.
//  Copyright © 2016 Sydna Agnehs. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {


    @IBOutlet weak var pokemon_image: UIImageView!
    @IBOutlet weak var pokemon_name: UILabel!
    @IBOutlet weak var pokemon_cp: UILabel!
    @IBOutlet weak var pokemon_location: UILabel!
    @IBOutlet weak var trainer_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
