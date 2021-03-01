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
    
    func displayArticle(_article:Article) {
        
        //clean up the cell to display the image view
        articleImageView.image = nil
        headlineLabel.text = ""
        
        //keep a reference to the article
        articleToDisplay = _article
        
        
        //set the headline
        headlineLabel.text = articleToDisplay!.title
        
        //download and display  the image
        
        //check that thr article has an image
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        //create URL String
        let urlString = articleToDisplay!.urlToImage!
        
        // check the CacheManager before downloading any image data
        if let imageData = CacheManager.retrieveData(urlString){
            
            // there is image data, set the imageview and return (optional Binding)
            
            articleImageView.image = UIImage(data: imageData)
            return
        }
        
        // create the URL
        let url = URL(string: urlString)
        
        // check that the URL is not NIL
        guard url != nil else {
            print("couldnt create a url object")
            return
        }
        
        // get a URL Session
        let session = URLSession.shared
        
        // create a Data task
        let dataTask = session.dataTask(with: url!) { [self] (data, response, error) in
            
            // check that there were not errors
            if error == nil && data != nil {
                
                //save the data into Cache
                CacheManager.saveData(urlString, data!)
                
                //check that the url string that the data task went off to download matches the article is set to display
                if articleToDisplay!.urlToImage == urlString {
                    DispatchQueue.main.async {
                        self.articleImageView.image = UIImage(data:data!)
                        
                    }
                    
                }//end if
                
                
            } //end data task
            
        }
        
    // kick off the data task
            dataTask.resume()
            
        }
    }

