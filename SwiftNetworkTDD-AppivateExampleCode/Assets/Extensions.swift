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

extension UIViewController: StoryboardCreatable {
  
  @objc class var storyboard: UIStoryboard {
    let name = Self.storyboardName
    let bundle = Self.storyboardBundle
    return UIStoryboard(name: name, bundle: bundle)
  }
  
  @objc class var storyboardBundle: Bundle? {
    return Bundle(for: self)
  }
  
  @objc class var storyboardName: String {
    return "Main"
  }
  
  @objc class var storyboardIdentifier: String {
    return "\(self)"
  }
  
  @objc final class func instanceFromStoryboard() -> Self {
    let storyboardViewController = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier)
    guard let viewController = storyboardViewController as? Self else {
      fatalError(
        "View controller on storyboard named \(storyboardName) " +
          "was expected to be an instance of type \(type(of: self)), " +
          "but it's actually an instance of \(type(of: storyboardViewController)). " +
        "Fix the type in the storyboard and/or overrride `storyboardIdentifier` with the right value")
    }
    return viewController
  }
}
