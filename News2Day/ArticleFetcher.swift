//
//  ArticleFetcher.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/02/18.
//

import Foundation

protocol ArticleFetcherDelegate: AnyObject {
    func articleFetcher(_ articleFetcher: ArticleFetcher, didReceiveSections sections:[Section])
}

class ArticleFetcher {
    
    weak var delegate: ArticleFetcherDelegate?
    
    func getArticles() {
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=037e3e467b1a4147ab81ffc899571fc9&pageSize=100")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                return
            }
            do {
                // Decide JSON data and convert string into date
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let feed = try decoder.decode(ArticleFeedAPIResponse.self, from: data)
                
                // if there are no images or content filter it out of the news feed
                let articles = feed.articles.filter({ $0.urlToImage != nil && $0.content != nil })
                
                let articleFeed = articles
                
                let firstArticles = articles.prefix(4)
        
                let secondArticles = articles.suffix(4)
                
                let sections = [
                    
                    Section(title: "Todays News", articles: Array(firstArticles)),
                    Section(title: "Yesterdays News", articles: Array(secondArticles))
                ]

               
                let originalJSON = try! JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0))
                print(originalJSON)
                
                //pass it back to the view controller in the main thread
                DispatchQueue.main.async {
                    self.delegate?.articleFetcher(self, didReceiveSections: sections)
                }
            }
            catch  {
                print("error parsing the JSON")
            }
        }.resume()
    }
    
    
}

struct Section {
    
    let title: String
    let articles: [Article]
}





   

