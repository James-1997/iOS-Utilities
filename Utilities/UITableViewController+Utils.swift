//
//  UITableViewController+Utils.swift
//  Utilities
//
//  Created by Robson James Junior on 23/06/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewController {
  public func getCell(tableView: UITableView,
                       indexPath: IndexPath,
                       identifier: String) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: identifier,
                                         for: indexPath)
  }
}
