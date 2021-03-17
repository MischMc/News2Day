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
                var articlesByDay: [Date: [Article]] = [:]
                
                for article in articles {
                    let date = article.publishedAt ?? Date()
                    let year = Calendar.current.component(.year, from: date)
                    let month = Calendar.current.component(.month, from:date)
                    let day = Calendar.current.component(.day, from: date)
                    
                    let sectionName = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
                    
                    var articles = articlesByDay[sectionName] ?? []
                    articles.append(article)
                    articlesByDay[sectionName] = articles
                }
                
                let keysSorted = articlesByDay.keys.sorted(by: { $0 > $1})
                
                var sections: [Section] = []
                
                let dateFormatter = DateFormatter()
                
                for key in keysSorted {
                    let articles = articlesByDay[key]!
                    dateFormatter.dateStyle = .medium
                    sections.append(.init(title: dateFormatter.string(from: key), articles: articles))
                }
                
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







