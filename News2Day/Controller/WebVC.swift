//
//  WebVC.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/03/18.
//

import Foundation
import UIKit
import WebKit

class WebVC: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    let article: Article
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        guard let urlString = self.article.url,
              let url = URL(string: urlString)
        else {
            return
        }
        
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        
    }
    
    
    
    
}


