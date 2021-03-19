//
//  ArticleCell.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/02/25.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    
    var articleToDisplay: Article?
    
    func configure(with article: Article) {
        
        
        articleImageView.image = nil
        articleImageView.alpha = 0
        headlineLabel.text = ""
        headlineLabel.alpha = 0
        authorName.text = ""
        authorName.alpha = 0
        articleToDisplay = article
        headlineLabel.text = article.title
        authorName.text = article.author
        
        
        UIView.animate(withDuration: 0.6, delay: 0, options:.curveEaseOut,
                       animations:{
                        
                        self.headlineLabel.alpha = 1
                        self.authorName.alpha = 1
                        
                       }, completion: nil)
        
        guard article.urlToImage != nil else {
            return
        }
        
        let urlString = article.urlToImage!
        
        if let imageData = CacheManager.retrieveData(forURL: urlString){
            
            articleImageView.image = UIImage(data: imageData)
            
            UIView.animate(withDuration: 0.6, delay: 0, options:.curveEaseOut,
                           animations:{
                            
                            self.articleImageView.alpha = 1
                            
                           }, completion: nil)
            
            return
        }
        
        guard let url = URL(string: urlString) else {
            
            print("couldnt create a url object")
            
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { [self] (data, response, error) in
            
            guard let data = data else {
                return
            }
            
            CacheManager.saveData(forURL: urlString, imageData: data)
            
            if articleToDisplay?.urlToImage == urlString {
                DispatchQueue.main.async {
                    self.articleImageView.image = UIImage(data:data)
                    
                    UIView.animate(withDuration: 0.6,
                                   delay: 0,
                                   options:.curveEaseOut,
                                   animations:{
                                    self.articleImageView.alpha = 1
                                   }, completion: nil)
                    
                }
            } 
            
        }.resume()
    }
}

