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
        
        // get the articles from the ArticleFetcher
        model.delegate = self
        model.getArticles()
        
        collectionView?.register(SectionHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier:SectionHeader.identifier)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerLabel = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as! SectionHeader
        
        headerLabel.configure(with: "Today's News")
        return headerLabel
    }
}


extension NewsFeedVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: min(200, collectionView.bounds.width), height: 40)
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

