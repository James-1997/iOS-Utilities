//
//  UIViewController.swift
//  Utilities
//
//  Created by Robson James Junior on 21/06/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  //MARK: KeyBoard
  @objc public func hideKeyboard() {
    view.endEditing(true)
  }
  
  public func hidenKeyboardOnTap(withSelector selector: Selector = #selector(hideKeyboard)) {
    let gesture = UITapGestureRecognizer(target: self, action: selector)
    gesture.cancelsTouchesInView = true
    view.addGestureRecognizer(gesture)
  }
  
  //MARK: NavigationController
  public func hideBackButtonText() {
      self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
  }
}
