//
//  LocalFetchPlugin.swift
//  LocalFetch
//
//  Created by plu on 2/20/19.
//

import Foundation
import XWKWebView

public class LocalFetchPlugin: NSObject {
    @objc func load(_ payload: AnyObject?, _ promise: XWKWebViewPromise) {
        print("payload from JS: \(payload)")
        let nativePayload = "{\"data\": \"something useful\"}"
        promise.resolve(nativePayload)
    }
}
