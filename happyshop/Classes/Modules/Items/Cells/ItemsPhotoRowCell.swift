//
//  ItemsPhotoRowCell.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/17/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import UIKit
import Eureka

final class ItemsPhotoRowCell: Cell<Item>, CellType {

    @IBOutlet weak var imageItemPhoto: UIImageView!
    
    required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        // we do not want our cell to be selected in this case.
        // If you use such a cell in a list then you might want to change this.
        selectionStyle = .none
        
        // configure our profile picture imageView
        imageItemPhoto.contentMode = .scaleAspectFill
        imageItemPhoto.clipsToBounds = true
        
        
        // specify the desired height for our cell
        height = { return 80 }
        
        // set a light background color for our cell
        backgroundColor = UIColor(red:0.984, green:0.988, blue:0.976, alpha:1.00)                    
    }
    
    override func update() {
        super.update()
        
        // we do not want to show the default UITableViewCell's textLabel
        textLabel?.text = nil
        
        // get the value from our row
    }
}

final class ItemsPhotoRow: Row<ItemsPhotoRowCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<ItemsPhotoRowCell>(nibName: "ItemsPhotoRowCell")
    }
}
