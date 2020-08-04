//
//  UIImageView+Extension.swift
//  Utilities
//
//  Created by Robson James Junior on 25/06/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
  @objc public func downloaded(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      DispatchQueue.main.async() {
        self.image = image.withRenderingMode(.alwaysTemplate)
        if let parent = self.superview {
          parent.reloadInputViews()
        }
      }
      }.resume()
  }
  
  @objc public func downloaded(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    guard let url = URL(string: link) else { return }
    downloaded(url: url, contentMode: mode)
  }
}
