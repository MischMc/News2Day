//
//  DetailViewController.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/02/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var articleUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // check that there is a url
            
        //create the url object
    
        // couldnt create the url object
        guard let article = articleUrl, let url = URL(string: article) else {
            
            return
        }
        // create the url request object
        let request = URLRequest (url: url)
            
        //start spinner
            spinner.alpha = 1
            spinner.startAnimating()
            
        // Load it in the web view
        webView.load(request)
            
            
            
            
            
        }
        
    }

extension DetailViewController:WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // stop the spinner and hide it
        spinner.stopAnimating()
        spinner.alpha = 0
    }
}
    

