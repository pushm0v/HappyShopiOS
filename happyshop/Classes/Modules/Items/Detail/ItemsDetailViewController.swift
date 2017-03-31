//
//  ItemsDetailViewController.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/13/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import PKHUD

protocol IItemsDetailView: class {
    func showLoading(show: Bool)
}

class ItemsDetailViewController: FormViewController {

    var presenter: IItemsDetailPresenter!
    let pkHUD = PKHUD.sharedHUD
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pkHUD.contentView = PKHUDProgressView()
        
        form +++ Section("Item Detail")
            <<< TextRow(){ row in
                row.tag = "name"
                row.title = "Item Name"
                row.placeholder = "Loyang, Panci, dll"
            }
            <<< IntRow(){ row in
                row.tag = "qty"
                row.title = "Item Qty"
                row.placeholder = "0"
            }
            <<< TextRow(){ row in
                row.tag = "description"
                row.title = "Item Desc."
                row.placeholder = "Loyang hitam uk. 22"
            }
            <<< ImageRow(){ row in
                row.tag = "image"
                row.title = "Item Image"
                row.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum, .Camera]
                row.clearAction = .yes(style: .default)
            }
            +++ Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Save"
                }
                .onCellSelection { [weak self] (cell, row) in
                    if let values: [String: Any] = self?.form.values() as? [String : Any] {
                        self?.presenter.save(values: values)
                    }
            }
    }
}

extension ItemsDetailViewController: IItemsDetailView {
    func showLoading(show: Bool) {
        if show {
            pkHUD.show()
        }
        else {
            pkHUD.hide()
        }
    }
}
