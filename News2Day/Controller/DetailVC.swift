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
        
        let articleTitle = UILabel()
        articleTitle.text = article.title
        articleTitle.font = UIFont.preferredFont(forTextStyle: .title2)
        articleTitle.textColor = UIColor.label
        articleTitle.adjustsFontForContentSizeCategory = true
        articleTitle.numberOfLines = 0
        
        let authorName = UILabel()
        authorName.text = article.author
        authorName.font = UIFont.preferredFont(forTextStyle: .caption2)
        authorName.textColor = UIColor.secondaryLabel
        authorName.adjustsFontForContentSizeCategory = true
        authorName.numberOfLines = 0
        
        let articleDescription = UILabel()
        articleDescription.text = article.description
        articleDescription.font = UIFont.preferredFont(forTextStyle: .caption1)
        articleDescription.textColor = UIColor.secondaryLabel
        articleDescription.adjustsFontForContentSizeCategory = true
        articleDescription.numberOfLines = 0
        
        let textView = UITextView()
        textView.text = article.content
        textView.font = .preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        textView.isScrollEnabled = false
        
        
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
        let stackView = UIStackView (arrangedSubviews: [articleTitle,authorName,articleDescription,imageView,textView])
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 8
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.readableContentGuide.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5, constant: 0).isActive = true

    }
}



