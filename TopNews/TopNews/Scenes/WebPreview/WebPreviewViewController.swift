//
//  WebPreviewViewController.swift
//  TopNews
//
//  Created by Jelena Radojkovic on 12.11.22..
//

import Foundation
import UIKit
import WebKit

class WebPreiewViewController: UIViewController {
    let webView = WKWebView()
    var urlString: String? = nil
    
    override func viewDidLoad() {
        webView.frame = view.bounds
        view.addSubview(webView)
        
        guard let urlString = urlString else { return }
        guard let url = URL(string: urlString) else { return }
        
        addRefreshControl()
        webView.load(URLRequest(url: url))
    }
}

// MARK: Refresh control
extension WebPreiewViewController {
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshWebView(_:)), for: UIControl.Event.valueChanged)
        webView.scrollView.addSubview(refreshControl)
        webView.scrollView.bounces = true
    }
    
    @objc
    func refreshWebView(_ sender: UIRefreshControl) {
        webView.reload()
        sender.endRefreshing()
    }
}
