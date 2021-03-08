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
    var articleToDisplay: Article?
    
    func configure(with article: Article) {
        
        //clean up the cell to display the image view
        articleImageView.image = nil
        articleImageView.alpha = 0
        headlineLabel.text = ""
        headlineLabel.alpha = 0
        
        //keep a reference to the article
        articleToDisplay = article
        
        
        //set the headline
        headlineLabel.text = article.title
        
        //animate the label into view
        UIView.animate(withDuration: 0.6, delay: 0, options:.curveEaseOut,
                       animations:{
                        
                        self.headlineLabel.alpha = 1
                        
                       }, completion: nil)
        
        //download and display  the image
        
        //check that thr article has an image
        guard article.urlToImage != nil else {
            return
        }
        
        //create URL String
        let urlString = article.urlToImage!
        
        // check the CacheManager before downloading any image data
        if let imageData = CacheManager.retrieveData(forURL: urlString){
            
            // there is image data, set the imageview and return (optional Binding)
            
            articleImageView.image = UIImage(data: imageData)
            
            UIView.animate(withDuration: 0.6, delay: 0, options:.curveEaseOut,
                           animations:{
                            
                            self.articleImageView.alpha = 1
                            
                           }, completion: nil)
            
            return
        }
        
        // check that the URL is not NIL
        guard let url = URL(string: urlString) else {
            
            print("couldnt create a url object")
            
            return
        }
        
        // get a URL Session
        let session = URLSession.shared
        
        // create a Data task
        session.dataTask(with: url) { [self] (data, response, error) in
            
            // check that there were not errors
            guard let data = data else {
                return
            }
            //save the data into Cache
            CacheManager.saveData(forURL: urlString, imageData: data)
            
            //check that the url string that the data task went off to download matches the article is set to display
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

