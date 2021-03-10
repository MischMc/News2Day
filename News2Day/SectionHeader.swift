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
        headerLabel.textAlignment = .left
        headerLabel.textColor = .label
        headerLabel.font = .preferredFont(forTextStyle: .subheadline)
        return headerLabel
        
    }()
    
    public func configure(with label: String) {
        headerLabel.text = label
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(headerLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.frame = bounds
    }
    
}
