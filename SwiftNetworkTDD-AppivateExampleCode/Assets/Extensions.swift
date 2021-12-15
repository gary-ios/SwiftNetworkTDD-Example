//
//  Extensions.swift
//  SwiftNetworkTDD-AppivateExampleCode
//
//  Created by Gary Maccabe on 14/12/2021.
//

import UIKit

extension UITableViewCell {
    class var identifier: String {
      return "\(self)"
  }
}

extension UIViewController: NibCreatable {
  @objc final class var nib: UINib {
    let nibName = Self.nibName
    let nibBundle = Self.nibBundle
    return UINib(nibName: nibName, bundle: nibBundle)
  }
  
  @objc class var nibBundle: Bundle? {
    return Bundle(for: self)
  }
  
  @objc class var nibName: String {
    return "\(self)"
  }
  
  @objc final class func instanceFromNib() -> Self {
    return Self.init(nibName: nibName, bundle: nibBundle)
  }
}

extension UIView: NibCreatable {
  
  @objc final class var nib: UINib {
    let nibName = Self.nibName
    let nibBundle = Self.nibBundle
    return UINib(nibName: nibName, bundle: nibBundle)
  }
  
  @objc class var nibBundle: Bundle? {
    return Bundle(for: self)
  }
  
  @objc class var nibName: String {
    return "\(self)"
  }
  
  @objc class func instanceFromNib() -> Self {
    return nib.instantiate(withOwner: nil, options: nil).last as! Self
  }
}
