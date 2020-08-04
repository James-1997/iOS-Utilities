//
//  OSLog.swift
//  Utilities
//
//  Created by Robson James Junior on 25/06/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import Foundation
import os.log
 
extension OSLog {
  /// **Default unique** subsystem identifier for that app.
  private static var subsystem = Bundle.main.bundleIdentifier ?? "unknown identifier in app"
 
  // MARK: - Log Categories
  /// Use to identifier events of TaskManager Feature
  public static let taskManager = OSLog(subsystem: subsystem, category: "TaskManager")
  /// Use to identifier events of Workday Feature
  public static let workdayManager = OSLog(subsystem: subsystem, category: "WorkdayManager")
 
  // MARK: - Public Custom Log Methods
  /// Use to run log with description message
  /// - Parameter message: Message description of log
  /// - Parameter type: Logging levels supported by the system. Used just with iOS 12.0  and later
  /// - Parameter log: Set which category of that log. Used just with iOS 12.0 and later
  public static func log(message: String, type: OSLogType, log: OSLog,
                         file: String = #file, line: Int = #line, method: String = #function) {
    #if DEBUG
    if #available(iOS 12.0, *) {
      os_log(type, log: log, "%@", format(message: message, file: file, line: line, method: method))
    } else {
      NSLog(format(message: message, file: file, line: line, method: method))
    }
    #endif
  }
 
  // MARK: - Private Helper Methods
  /// This method format the log message adding debug informations
  private static func format(message: String, file: String, line: Int, method: String) -> String {
    let fileLastPath = String.init(stringLiteral: String(file.split(separator: "/").last!))
    let arguments = [fileLastPath, method, line] as [CVarArg]
    return String.init(format: "On file: %@ at method: %@ line: %ld log message: \(message)", arguments: arguments)
  }
}
