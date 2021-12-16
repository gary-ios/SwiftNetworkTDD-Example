//
//  Beer.swift
//  SwiftNetworkTDD-AppivateExampleCode
//
//  Created by Gary Maccabe on 15/12/2021.
//

import Foundation

struct Beer : Decodable, Equatable {
    let id: String
    let sellerID: String
    let imageURL: URL
    let name: String
}
