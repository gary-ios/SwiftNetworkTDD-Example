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

protocol StoryboardCreatable: AnyObject {
  static var storyboard: UIStoryboard { get }
  static var storyboardBundle: Bundle? { get }
  static var storyboardIdentifier: String { get }
  static var storyboardName: String { get }
  
  static func instanceFromStoryboard() -> Self
}
