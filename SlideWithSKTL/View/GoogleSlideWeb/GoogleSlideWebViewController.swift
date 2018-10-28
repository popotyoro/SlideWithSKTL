//
//  GoogleSlideWebViewController.swift
//  RTM
//
//  Created by popota on 2018/10/27.
//  Copyright © 2018 Tagayasu. All rights reserved.
//

import Cocoa
import WebKit

class GoogleSlideWebViewController: NSViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.1 Safari/605.1.15"
        webView.load(URLRequest(url: URL(string: "https://drive.google.com/drive/my-drive")!))
    }
    
}


extension GoogleSlideWebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil, navigationAction.request.url?.description.count ?? 0 > 0 {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
