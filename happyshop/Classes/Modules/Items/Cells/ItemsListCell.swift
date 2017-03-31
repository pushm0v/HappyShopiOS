//
//  ItemsListCell.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/13/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import UIKit

class ItemsListCell: UITableViewCell {
    @IBOutlet weak var labelItemName: UILabel?
    @IBOutlet weak var labelItemQty: UILabel?
    
    var item: Item? {
        didSet {
            if let name = item?.name {
                labelItemName?.text = name
            }
            if let qty = item?.qty {
                labelItemQty?.text = String(qty)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
