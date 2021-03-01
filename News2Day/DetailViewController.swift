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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
