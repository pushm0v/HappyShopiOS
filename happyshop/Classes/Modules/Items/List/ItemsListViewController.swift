//
//  ItemsListViewController.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/12/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import UIKit

protocol IItemsListView: class {
    func setLoading(loading: Bool)
    func reload()
}

class ItemsListViewController: UIViewController {

    var presenter: IItemsListPresenter!
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    
    init() {
        super.init(nibName: "ItemsListViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Items List"
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.start()
    }
    
    func setupTableView() {
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.register(UINib(nibName: "ItemsListCell", bundle: nil), forCellReuseIdentifier: "ItemsListCell")
    }
}

extension ItemsListViewController: IItemsListView {
    func setLoading(loading: Bool) {
        tableView?.isHidden = loading
        loadingIndicator?.isHidden = !loading
        if loading {
            loadingIndicator?.startAnimating()
        }
        else {
            loadingIndicator?.stopAnimating()
        }
    }
    
    func reload() {
        tableView?.reloadData()
    }
}

extension ItemsListViewController: UITableViewDelegate {
    
}

extension ItemsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsListCell", for: indexPath) as! ItemsListCell
        cell.item = presenter.items[indexPath.row]
        
        return cell
    }
}
