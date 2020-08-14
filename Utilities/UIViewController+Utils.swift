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


@objc extension UIViewController {
  //MARK: - Is Modal
  public var isModal: Bool {
    let presentingIsModal = presentingViewController != nil
    let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
    let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
 
    return presentingIsModal || presentingIsNavigation || presentingIsTabBar
  }
 
  public func push(viewController: UIViewController, hideBottomBar: Bool) {
    viewController.hidesBottomBarWhenPushed = hideBottomBar
    self.navigationController?.pushViewController(viewController, animated: true)
  }
 
  public func present(viewController: UIViewController, completion: (() -> Void)?) {
    DispatchQueue.main.async {
      self.navigationController?.present(viewController, animated: true, completion: completion)
    }
  }
 
  public func popViewController(animated: Bool = true) {
     self.navigationController?.popViewController(animated: animated)
  }
 
  public func setTitleView(withTitle title: String? = nil, andSubtitle subtitle: String? = nil,isToClear: Bool = false) {
    if isToClear {
      self.navigationController?.navigationBar.topItem?.titleView = nil
      return
    }
    let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))
 
    titleLabel.backgroundColor = .clear
    titleLabel.textColor = .black
    titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
    titleLabel.text = title
    titleLabel.sizeToFit()
 
    let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
    subtitleLabel.backgroundColor = .clear
    subtitleLabel.textColor = .black
    subtitleLabel.font = UIFont.systemFont(ofSize:12)
    subtitleLabel.text = subtitle
    subtitleLabel.sizeToFit()
 
    let titleView = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: max(titleLabel.frame.size.width,
                                                    subtitleLabel.frame.size.width),
                                         height: 30))
    titleView.addSubview(titleLabel)
    titleView.addSubview(subtitleLabel)
 
    let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
    let newX = widthDiff / 2
    subtitleLabel.frame.origin.x = (widthDiff < 0) ? abs(newX) : newX
    self.navigationController?.navigationBar.topItem?.titleView = titleView
  }
  
  public func setLargeTitle(title: String) {
    self.title = title
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationItem.largeTitleDisplayMode = .always
  }
}
 
 
//MARK: - Keyboard + UIScrollView
@objc extension UIViewController {
  public func setKeyboardWillHide(notification: NSNotification,
                                  scrollView: UIScrollView,
                                  bottomConstraint: NSLayoutConstraint?) {
    guard let userInfo = notification.userInfo else { return }
    guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    let keyboardFrame = keyboardSize.cgRectValue
    moveScreen(up: true,
               distance: keyboardFrame.height,
               scrollView: scrollView,
               bottomContraint: bottomConstraint)
  }
 
  public func setKeyboardWillShow(notification: NSNotification,
                                  scrollView: UIScrollView,
                                  bottomConstraint: NSLayoutConstraint?,
                                  height: CGFloat = 0) {
    guard let userInfo = notification.userInfo else { return }
    guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    let keyboardFrame = keyboardSize.cgRectValue
    moveScreen(up: false,
               distance: keyboardFrame.height + height,
               scrollView: scrollView,
               bottomContraint: bottomConstraint)
  }
 
  public func moveScreen(up: Bool,
                          distance: CGFloat,
                          scrollView: UIScrollView,
                          bottomContraint: NSLayoutConstraint?) {
    if view.frame.origin.y == 0 {
      UIView.animate(withDuration: 0.5, animations: {
        bottomContraint?.constant = up ? .zero : -distance
        self.view.layoutIfNeeded()
        if !up {
          self.moveToEndOfText(animated: true, scrollView: scrollView)
        }
      })
    }
  }
 
  public func moveToEndOfText(animated: Bool, scrollView: UIScrollView) {
    let y = scrollView.contentSize.height - scrollView.bounds.size.height
    let point = CGPoint(x: 0, y: y)
    scrollView.setContentOffset(point, animated: animated)
  }
}

