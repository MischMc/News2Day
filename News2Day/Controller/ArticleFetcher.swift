//
//  ArticleFetcher.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/02/18.
//

import Foundation

protocol ArticleFetcherDelegate: AnyObject {
    func articleFetcher(_ articleFetcher: ArticleFetcher, didReceiveSections sections: [Section])
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
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let feed = try decoder.decode(ArticleFeedAPIResponse.self, from: data)
                let articles = feed.articles.filter({ $0.urlToImage != nil && $0.content != nil })
                var articlesByDay: [Date: Array<Article>] = [:]
                
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
                
                let daysSorted = articlesByDay.keys.sorted(by: { $0 > $1})
                
                var sections: [Section] = []
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .full
                
                for day in daysSorted {
                    let articles = articlesByDay[day]!
                    let dayString = dateFormatter.string(from: day)
                    let section = Section(title: dayString, articles: articles)
                    sections.append(section)
                }
                
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







