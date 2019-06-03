//
//  SwiftyLog.swift
//  SwiftDemos
//
//  Created by Nitin A on 03/06/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import Foundation

let logEnvironment = LogEnvironment.all
enum LogEnvironment: String {
    case onlyAPI = "API Logs"
    case onlyMethod = "Method Logs"
    case onlyTODO = "TODO Logs"
    case all = "All Logs"
    case other = "Other Logs"
    case none = "No Logs"
    case warning = "Warning Logs"
}

enum LogDateFormatter: String {
    case k_dd_mm_yyyy_HH_mm_ss = "dd-MM-yyyy HH:mm:ss"
    case k_dd_MMM_yyyy_HH_mm_ss = "dd MMM, yyyy HH:mm:ss"
}

struct LogManager {
    static func stats(_ file: String = #file, function: String = #function, line: Int = #line) -> String {
        let fileString: NSString = NSString(string: file)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = LogDateFormatter.k_dd_mm_yyyy_HH_mm_ss.rawValue
        return "[\(dateFormatter.string(from: Foundation.Date()))] [\(fileString.lastPathComponent) -> \(function), line:\(line)] ~~>"
    }
}

enum log {
    case success_api(_: String)
    case success(_: String)
    case warning(_: String)
    case error_api(_: String)
    case error(_: String)
    case todo(_: String)
    case url(_: String)
    case method(_: String)
    case other(_: String)
    case value_api(_: String)
}

postfix operator /

postfix func / (target: log?) {
    
    guard let target = target else { return }
    
    func log<T>(_ emoji: String, _ object: T) {
        print(emoji + " " + String(describing: object))
    }
    
    if logEnvironment == LogEnvironment.none { return }
    
    switch target {
    case .success(let success):
        if logEnvironment == LogEnvironment.all {
            log("✅", "\(LogEnvironment.all.rawValue): " + success)
        }
        
    case .success_api(let success):
        if logEnvironment == LogEnvironment.onlyAPI || logEnvironment == LogEnvironment.all {
            log("✅","\(LogEnvironment.onlyAPI.rawValue): " +  success)
        }
        
    case .warning(let warning):
        if logEnvironment == LogEnvironment.warning || logEnvironment == LogEnvironment.all {
            log("⚠️","\(LogEnvironment.warning.rawValue): " +  warning)
        }
        
    case .error(let error):
        if logEnvironment == LogEnvironment.all {
            log("🛑","\(LogEnvironment.all.rawValue): " +  error)
        }
        
    case .error_api(let error):
        if logEnvironment == LogEnvironment.onlyAPI || logEnvironment == LogEnvironment.all {
            log("🛑","\(LogEnvironment.onlyAPI.rawValue): " +  error)
        }
        
    case .todo(let todo):
        if logEnvironment == LogEnvironment.onlyTODO || logEnvironment == LogEnvironment.all {
            log("👨🏼‍💻","\(LogEnvironment.onlyTODO.rawValue): " +  todo)
        }
        
    case .url(let url):
        if logEnvironment == LogEnvironment.all {
            log("🌏","\(LogEnvironment.all.rawValue): " +  url)
        }
        
    case .method(let success):
        if logEnvironment == LogEnvironment.onlyMethod || logEnvironment == LogEnvironment.all {
            log("✅","\(LogEnvironment.onlyMethod.rawValue): " +  success)
        }
        
    case .other(let message):
        if logEnvironment == LogEnvironment.other || logEnvironment == LogEnvironment.all {
            log("👻","\(LogEnvironment.other.rawValue): " +  message)
        }
    case .value_api(let value):
        if logEnvironment == LogEnvironment.onlyAPI || logEnvironment == LogEnvironment.all {
            log("🌏","\(LogEnvironment.onlyAPI.rawValue): " +  value)
        }
    }
}
