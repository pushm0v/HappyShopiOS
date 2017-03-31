//
//  HomeMenuCell.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/10/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import UIKit

class HomeMenuCell: UITableViewCell {

    @IBOutlet weak var viewMenuContainer: UIView?
    @IBOutlet weak var labelMenuName: UILabel!
    
    var menu: HomeMenu? {
        didSet {
            if let name = menu?.name {
                labelMenuName?.text = name
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10.0
        contentView.backgroundColor = UIColor.red
        viewMenuContainer?.alpha = 0.6
    }
    
}
