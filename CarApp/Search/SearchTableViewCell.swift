//
//  SearchTableViewCell.swift
//  CarApp
//
//  Created by Philip Starner on 3/9/18.
//  Copyright © 2018 Philip Starner. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var agency: UILabel!
    @IBOutlet weak var estimate: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    @IBOutlet weak var imageThumb: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.type.text = nil
        self.agency.text = nil
        self.estimate.text = nil
        self.distance.text = nil
        self.imageThumb.image = nil
    }

}
