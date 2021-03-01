//
//  ArticleModel.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/02/18.
//

import Foundation

protocol ArticleModelProtocol {
    func articlesRetrieved(_articles:[Article])
}

class ArticleModel {
    
    var delegate: ArticleModelProtocol?
    
    func getArticles() {
        
        // send off request to the API
        
        // create a string URL
        let stringUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=037e3e467b1a4147ab81ffc899571fc9"
        
        
        // create a URL object
        let url = URL(string: stringUrl)
        // check that it isnt NIL
        guard url != nil else {
            print("couldnt create the URL object")
            return
        }
        // get the URL session
        let session = URLSession.shared
        // create the data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
        // check that there are no errors and thay there is data
            if error == nil && data != nil {
        // attempt to parse the JSON
                let decoder = JSONDecoder()
               
                do {
                    // Parse the JSON into articleService
                    let articleService = try decoder.decode(ArticleService.self, from: data!)
                    // Get the articles
                    let articles = articleService.articles!
                    //pass it back to the view controller in the main thread
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(_articles:articles)
                    }
                }
                catch  {
                    print("error parsing the JSON")
                } //end do - catch
      
            } // end if
        } //end data Task
        
        // start the data task
        dataTask.resume()
    }
}
