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
    private var webView: WKWebView
    public static var enableLogging = true
    
    public init(_ webView: WKWebView) {
        self.webView = webView
        
        let bundle = Bundle(for: LocalFetch.self)
        //inject localFetch.js
        guard let path = bundle.path(forResource: "localFetch", ofType: "js"),
            let source = try? NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) else {
                LocalFetchUtil.log("Failed to read localFetch script: localFetch.js")
                return
        }
        let script = WKUserScript(source: source as String, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        let userContentController = webView.configuration.userContentController
        userContentController.addUserScript(script)
        
        let xwebview = XWKWebView(webView);
        xwebview.registerPlugin(LocalFetchPlugin(), namespace: "localFetch")
    }
}
