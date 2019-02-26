//
//  LocalFetch.swift
//  LocalFetch
//
//  Created by plu on 2/20/19.
//

import Foundation
import WebKit
import XWKWebView

public class LocalFetch {
    private var xwkWebView: XWKWebView
    public static var enableLogging = true
    
    public init(_ xwkWebView: XWKWebView) {
        self.xwkWebView = xwkWebView
        
        let bundle = Bundle(for: LocalFetch.self)
        //inject localFetch.js
        guard let path = bundle.path(forResource: "localFetch", ofType: "js"),
            let source = try? NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) else {
                LocalFetchUtil.log("Failed to read localFetch script: localFetch.js")
                return
        }
        let script = WKUserScript(source: source as String, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        let userContentController = xwkWebView.webView.configuration.userContentController
        userContentController.addUserScript(script)
    }
    
    public func registerRouteBase(_ obj: AnyObject, routeBase: String) {
        xwkWebView.registerPlugin(obj, namespace: routeBase)
    }
}
