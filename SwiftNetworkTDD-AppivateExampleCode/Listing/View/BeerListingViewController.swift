//
//  ViewController.swift
//  SwiftNetworkTDD-AppivateExampleCode
//
//  Created by Gary Maccabe on 14/12/2021.
//

import UIKit

class BeerListingViewController : UIViewController {
    
    private var beerViewModels : [BeerViewModel] = []
    
    @IBOutlet weak var tableView : UITableView! {
        didSet {
          tableView.register(
            ErrorTableViewCell.nib,
            forCellReuseIdentifier: ErrorTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
    }
    
    @objc func refreshData() {
        
    }
}

extension BeerListingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !tableView.refreshControl!.isRefreshing else {
            return 0
        }
        return max(beerViewModels.count, 1)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard beerViewModels.count > 0 else {
             return errorCell(tableView, indexPath)
           }
        return listingCell(tableView, indexPath)
    }
    
    private func listingCell(_ tableView: UITableView, _ indexPath: IndexPath) -> BeerListingTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerListingTableViewCell.identifier) as? BeerListingTableViewCell else { return BeerListingTableViewCell() }
        let viewModel = beerViewModels[indexPath.row]
        viewModel.configure(cell)
        return cell
    }
    
    private func errorCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: ErrorTableViewCell.identifier, for: indexPath)
    }
}
