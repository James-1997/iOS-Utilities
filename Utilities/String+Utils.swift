//
//  String+Utils.swift
//  Utilities
//
//  Created by Robson James Junior on 21/06/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import Foundation
import UIKit

extension String {
  public func getFirstElementInComponents(separetedBy separatedValue: String) -> String {
    return self.components(separatedBy: separatedValue)[0]
  }
}

extension String {
  public var isEmail: Bool {
    var regexText = ""
    regexText.append("(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}")
    regexText.append("~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\")
    regexText.append("x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-")
    regexText.append("z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5")
    regexText.append("]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-")
    regexText.append("9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21")
    regexText.append("-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
    return matchPattern(regexText)
  }
  
  static public func emailValidator(text: String) -> Bool {
    let trimmedText = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    return trimmedText.isEmail
  }
  
  static public func passwordValidator(text: String) -> Bool {
    guard text.matchPattern(".{8,}") else { return false }
    guard text.matchPattern("[a-z]+") ||
      text.matchPattern("[A-Z]+") ||
      text.matchPattern("\\d+") ||
      text.matchPattern("[^0-9a-zA-Z]")
      else { return false }
    return true
  }
  
  public func matchPattern(_ regexText: String) -> Bool {
    return range(of: regexText, options: .regularExpression) != nil
  }
  
  public func isEqualTo(string: String) -> Bool {
    return self == string
  }
  
  public var ignoreAccentuation: String {
    get {
      return self.folding(options: .diacriticInsensitive, locale: .current)
    }
  }
  
  public var haveLetters: Bool {
    get {
      return !self.withoutSpaces.isEmpty
    }
  }
  
  public var withoutSpaces: String {
    get {
      return self.components(separatedBy:.whitespacesAndNewlines).filter {
        $0.count > 0
      }.joined(separator: " ")
    }
  }
  
  public var isNumber: Bool {
    return trimmingCharacters(in: CharacterSet.decimalDigits).isEmpty
  }
}
