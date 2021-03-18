//
//  CollectionReusableView.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/03/10.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let identifier = "SectionHeader"
    
    private let headerLabel:UILabel =  {
        let headerLabel = UILabel()
        headerLabel.text = "Section Header"
        headerLabel.textAlignment = .center
        headerLabel.textColor = .label
        headerLabel.font = .preferredFont(forTextStyle: .title3)
        headerLabel.backgroundColor = .quaternarySystemFill
    
        return headerLabel
        
    }()
    
    public func configure(with label: String) {
        headerLabel.text = label
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(headerLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func configureConstraints() {
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leadingAnchor.constraint(equalTo:leadingAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo:topAnchor ).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo:trailingAnchor ).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo:bottomAnchor ).isActive = true
    }
    
}
