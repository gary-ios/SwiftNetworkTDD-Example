//
//  BeerViewModel.swift
//  SwiftNetworkTDD-AppivateExampleCode
//
//  Created by Gary Maccabe on 15/12/2021.
//

import UIKit

class BeerViewModel {
    
    let beer : Beer
    var imageURL : URL
    var name : String
    
    init(beer: Beer) {
        self.beer = beer
        self.imageURL = beer.imageURL
        self.name = beer.name
      }
        
    func configure(_ cell: BeerListingTableViewCell) {
        cell.nameLabel.text = name
    }
}

extension BeerViewModel: Equatable {
  static func == (lhs: BeerViewModel, rhs: BeerViewModel) -> Bool {
      return lhs.beer == rhs.beer
  }
}
