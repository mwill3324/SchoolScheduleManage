//
//  tableFile.swift
//  Final
//
//  Created by Marcus Williams on 11/15/17.
//  Copyright © 2017 Marcus Williams. All rights reserved.
//

import UIKit

class tableFileTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var label_cell: UILabel!
    @IBOutlet weak var image_Cell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

