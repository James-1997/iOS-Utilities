//
//  UIView+Utils.swift
//  Utilities
//
//  Created by Robson James Junior on 25/06/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  
  public func createBorder(withColor color: UIColor,andRadius radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.clipsToBounds = true
    self.layer.borderColor = color.cgColor
    self.layer.borderWidth = 1.0
  }
  
  public func fadeOut() {
    if self.alpha >= 0 {
      UIView.animate(withDuration: 1.5, delay: 0.2,
                     options: .curveEaseInOut,
                     animations: { self.alpha = 0.0 }) { (isDone) in
                      if isDone {
                        self.isHidden = true
                        self.alpha = 1.0
                      }
      }
    }
  }
  
  public func round(withMargin margin: CGFloat) {
    self.layer.masksToBounds = true
    self.layer.cornerRadius = margin
  }
}
