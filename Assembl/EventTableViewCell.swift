//
//  EventTableViewCell.swift
//  Assembl
//
//  Created by Kiara Wahnschafft on 5/5/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import UIKit

//MARK: Properties

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
