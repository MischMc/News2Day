//
//  DetailVC.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/02/23.
//

import UIKit



class DetailVC: UIViewController {
    
    let article: Article
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
                
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
        let imageView = UIImageView()
        
        if let urlString = article.urlToImage,
           let imageData = CacheManager.retrieveData(forURL: urlString) {
            
            imageView.image = UIImage(data: imageData)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
        }
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let articleTitle = UILabel()
        articleTitle.text = article.title
        articleTitle.font = UIFont.preferredFont(forTextStyle: .title2)
        articleTitle.textColor = UIColor.label
        articleTitle.adjustsFontForContentSizeCategory = true
        articleTitle.numberOfLines = 4
        
        let authorName = UILabel()
        authorName.text = article.author
        authorName.font = UIFont.preferredFont(forTextStyle: .title3)
        authorName.textColor = UIColor.secondaryLabel
        authorName.adjustsFontForContentSizeCategory = true
        authorName.numberOfLines = 2
        
        let articleDescription = UILabel()
        articleDescription.text = article.description
        articleDescription.font = UIFont.preferredFont(forTextStyle: .body)
        articleDescription.textColor = UIColor.secondaryLabel
        articleDescription.adjustsFontForContentSizeCategory = true
        articleDescription.numberOfLines = 6
        
        let textView = UITextView()
        textView.text = article.content
        textView.font = .preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        textView.isScrollEnabled = false
        
        let stackView = UIStackView (arrangedSubviews: [articleTitle,authorName,articleDescription,imageView,textView])
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 8
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate ([
            imageView.heightAnchor.constraint(equalToConstant: 200),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            
        ])
        
        
        
    }

}



