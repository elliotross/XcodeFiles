//
//  DetailViewController.swift
//  project7
//
//  Created by Elliot Ross on 02/05/2017.
//  Copyright © 2017 Elliot Ross. All rights reserved.
//

import UIKit
import WebKit
// This inports the UI Kits for use in code.

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: [String: String]!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard detailItem != nil else { return }
        
        if let body = detailItem["body"] {
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
            html += "<style> body { font-size: 150%; } </style>"
            html += "</head>"
            html += "<body>"
            html += body
            html += "</body>"
            html += "</html>"
            webView.loadHTMLString(html, baseURL: nil)
        }// This code tell swift how to interept the html data from the url. It is basically saying that the data should be view in the WebKit and which the fonttype at 150% of the normal size.
    }
}
