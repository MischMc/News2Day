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
    var sections = [Section]()
    
    
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
        
        headerLabel.configure(with: sections[indexPath.section].title)
        return headerLabel
    }
}


extension NewsFeedVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].articles.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        let section = sections[indexPath.section]
        let currentArticle = section.articles[indexPath.item]
        cell.configure(with: currentArticle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: min(200, collectionView.bounds.width), height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = sections[indexPath.section]
        let currentArticle = section.articles[indexPath.item]
        let detailVC = DetailVC(article: currentArticle)
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}
extension NewsFeedVC: ArticleFetcherDelegate {
    func articleFetcher(_ articleFetcher: ArticleFetcher, didReceiveSections sections: [Section]) {
        
        
        self.sections = sections
        
        //refresh the collectionView
        self.collectionView.reloadData()
    }
}

