//
//  ViewController.swift
//  SwiftNetworkTDD-AppivateExampleCode
//
//  Created by Gary Maccabe on 14/12/2021.
//

import UIKit

class BeerListingViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BeerListingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return listingCell(tableView, indexPath)
    }
    
    private func listingCell(_ tableView: UITableView, _ indexPath: IndexPath) -> BeerListingTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerListingTableViewCell.identifier) as? BeerListingTableViewCell else { return BeerListingTableViewCell() }
       return cell
    }
}


class BeerListingTableViewCell : UITableViewCell {}


extension UITableViewCell {
    class var identifier: String {
      return "\(self)"
  }
}
