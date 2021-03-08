//
//  ArticleFetcher.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/02/18.
//

import Foundation

protocol ArticleFetcherDelegate: AnyObject {
    func articleFetcher(_ articleFetcher: ArticleFetcher, didReceiveArticles articles:[Article])
}

class ArticleFetcher {
    
    weak var delegate: ArticleFetcherDelegate?
    
    func getArticles() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=037e3e467b1a4147ab81ffc899571fc9")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                return
            }
            do {
                // Parse the JSON into JSONObject
                let decoder = JSONDecoder()
                let feed = try decoder.decode(ArticleFeedAPIResponse.self, from: data)
                let articles = feed.articles
                
                //pass it back to the view controller in the main thread
                DispatchQueue.main.async {
                    self.delegate?.articleFetcher(self, didReceiveArticles: articles)
                }
            }
            catch  {
                print("error parsing the JSON")
            }
        }.resume()
    }
}
