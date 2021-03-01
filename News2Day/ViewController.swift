//
//  ViewController.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/02/17.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = ArticleModel()
    var articles = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the view controller as the data source and delegate of the collection View
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // get the articles from the article model
        
        model.delegate = self
        model.getArticles()
    }
    
    var selectedIndexPath: IndexPath?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      // detect which indexPath the user selected
        
        
        guard let indexPath = selectedIndexPath else {
            
            //the user hasnt selected anything
            
            return
        }
        // get the article the user tapped
        let article = articles[indexPath.row]
        
        // get a reference to the detail view controller
        let detailVC = segue.destination as! DetailViewController
        
        // Pass the article URL to the detail view controller
        detailVC.articleUrl = article.url!
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath)as!ArticleCell
        
        //get the artile that the collectionview is asking about
        let article = articles[indexPath.row]
        
        
        // customize it
        cell.displayArticle(_article: article)
        
        // Return the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
}
extension ViewController: ArticleModelProtocol {
    
    // MARK: - Article Model Protocol Methods
    
    func articlesRetrieved(_articles: [Article]) {
        
        //set the articles property of the view controller to the articles passed back from the model
        
        self.articles = _articles
        
        //refresh the collectionView
        collectionView.reloadData()
        
        
    }
    
    
}
