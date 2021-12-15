//
//  Protocols.swift
//  SwiftNetworkTDD-AppivateExampleCode
//
//  Created by Gary Maccabe on 15/12/2021.
//

import UIKit

protocol NibCreatable: AnyObject {
  static var nib: UINib { get }
  static var nibBundle: Bundle? { get }
  static var nibName: String { get }
  static func instanceFromNib() -> Self
}
