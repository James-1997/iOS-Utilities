//
//  UIImage+Utils.swift
//  Utilities
//
//  Created by Robson James Junior on 25/06/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

  @objc public var breadth:CGFloat { return min(size.width, size.height) }
  
  @objc public var squareCroped: UIImage {
    let height = size.height
    let width = size.width
    let cgimage = self.cgImage!
    let contextImage: UIImage = UIImage(cgImage: cgimage)
    let contextSize: CGSize = contextImage.size
    var posX: CGFloat = 0.0
    var posY: CGFloat = 0.0
    var cgwidth: CGFloat = CGFloat(width)
    var cgheight: CGFloat = CGFloat(height)
   
    // See what size is longer and create the center off of that
    if contextSize.width > contextSize.height {
      posX = ((contextSize.width - contextSize.height) / 2)
      posY = 0
      cgwidth = contextSize.height
      cgheight = contextSize.height
    } else {
      posX = 0
      posY = ((contextSize.height - contextSize.width) / 2)
      cgwidth = contextSize.width
      cgheight = contextSize.width
    }
   
    let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
   
    // Create bitmap image from context using the rect
    let imageRef: CGImage = cgimage.cropping(to: rect)!
   
    // Create a new image based on the imageRef and rotate back to the original orientation
    let image = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
    return image
  }
  
  @objc public var circleMasked: UIImage? {
    return circleImage(diameter: breadth)
  }
  
  @objc public func circleImage(diameter: CGFloat) -> UIImage? {
    var breadthSize: CGSize  { return CGSize(width: diameter, height: diameter) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    UIGraphicsBeginImageContextWithOptions(breadthSize, false, 0)
    let context = UIGraphicsGetCurrentContext()!
    context.setAllowsAntialiasing(true);
    context.setShouldAntialias(true);
    defer { UIGraphicsEndImageContext() }
    UIBezierPath(ovalIn: breadthRect).addClip()
    UIImage(cgImage: squareCroped.cgImage!, scale: 0, orientation: imageOrientation)
      .draw(in: breadthRect)
    return UIGraphicsGetImageFromCurrentImageContext()
  }
  
  @objc func resizeImage(scale: CGFloat) -> UIImage? {
    let newHeight = self.size.height * scale
    let newWidth = self.size.width * scale
    UIGraphicsBeginImageContext(CGSize.init(width: newWidth, height: newHeight))
    self.draw(in: CGRect.init(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }
  
  @objc func resizeImage(size: CGSize) -> UIImage {
    let newImage = UIGraphicsImageRenderer(size:size).image { _ in
      self.draw(in: CGRect(origin: .zero, size: size))
    }
    return newImage
  }
  
}
