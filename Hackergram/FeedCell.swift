//
//  FeedCell.swift
//  Hackergram
//
//  Created by Marc Gugliuzza on 10/9/14.
//  Copyright (c) 2014 77th Street Labs. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var postedImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
