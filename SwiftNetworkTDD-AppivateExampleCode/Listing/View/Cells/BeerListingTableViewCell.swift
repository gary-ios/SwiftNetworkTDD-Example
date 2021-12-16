//
//  BeerListingTableViewCell.swift
//  SwiftNetworkTDD-AppivateExampleCode
//
//  Created by Gary Maccabe on 14/12/2021.
//

import UIKit

class BeerListingTableViewCell : UITableViewCell {
    
    @IBOutlet var breederRatingImageView : UIImageView!
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var containerView : UIView! {
        didSet {
          let selectedBackgroundView = UIView(frame: containerView.frame)
          self.selectedBackgroundView = selectedBackgroundView
        }
    }
}
