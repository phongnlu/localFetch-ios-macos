//
//  LocalFetchUtil.swift
//  LocalFetch
//
//  Created by plu on 2/20/19.
//

import Foundation

public class LocalFetchUtil {
    static func log<T>(_ object: T, filename: String = #file, line: Int = #line, funcname: String = #function) {
        if LocalFetch.enableLogging {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss:SSS"
            let process = ProcessInfo.processInfo
            let threadId = "."
            
            NSLog("%@", "\(dateFormatter.string(from: Date())) \(process.processName))[\(process.processIdentifier):\(threadId)] \((filename as NSString).lastPathComponent)(\(line)) \(funcname):\r\t\(object)\n")
        }
    }
}
