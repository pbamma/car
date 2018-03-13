//
//  SearchTableViewCell.swift
//  CarApp
//
//  Created by Philip Starner on 3/9/18.
//  Copyright © 2018 Philip Starner. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var make: UILabel!
    
    @IBOutlet weak var model: UILabel!
    
    @IBOutlet weak var information: UILabel!
    
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
        self.make.text = nil
        self.model.text = nil
        self.information.text = nil
        self.imageThumb.image = nil
    }

}
