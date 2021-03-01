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
    
    var articleUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: articleUrl!)
        let request = URLRequest (url: url!)
        webView.load(request)
    }

}
