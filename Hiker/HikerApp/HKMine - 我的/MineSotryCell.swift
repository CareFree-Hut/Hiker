//
//  MineSotryCell.swift
//  Hiker
//
//  Created by 张驰 on 2019/9/11.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class MineSotryCell: UITableViewCell {

    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var personal: UILabel!
    @IBOutlet weak var locations: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
