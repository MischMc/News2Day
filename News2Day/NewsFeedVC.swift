//
//  ViewController.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/02/17.
//

import UIKit

class NewsFeedVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = ArticleFetcher()
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
}

extension NewsFeedVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
       //read up -  collectionview.register
        
        //get the article that the collectionview is asking about
        let article = articles[indexPath.item]
        
        // customize it
        cell.configure(with: article)
        
        // Return the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedIndex = indexPath.item
        let article = articles[selectedIndex]
        let detailVC = DetailVC(article: article)
        navigationController?.pushViewController(detailVC, animated: true)
    
    }
    
}
extension NewsFeedVC: ArticleFetcherDelegate {
    func articleFetcher(_ articleFetcher: ArticleFetcher, didReceiveArticles articles: [Article]) {
    
       

        self.articles = articles

        //refresh the collectionView
        collectionView.reloadData()
    }
}

