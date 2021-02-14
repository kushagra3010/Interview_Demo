//
//  SearchViewCollectionCell.swift
//  Interview_Demo
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import UIKit

class SearchViewCollectionCell: UICollectionViewCell {

    weak var imageView: UIImageView?
    
    private struct Constants {
        static let imageMargin: CGFloat = 5.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellView()
    }
    
    private func setupCellView() {

        let newImageView = UIImageView()
        newImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(newImageView)
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: newImageView.leadingAnchor, constant: 0),
            self.contentView.trailingAnchor.constraint(equalTo: newImageView.trailingAnchor, constant: 0),
            self.contentView.topAnchor.constraint(equalTo: newImageView.topAnchor, constant: 0),
            self.contentView.bottomAnchor.constraint(equalTo: newImageView.bottomAnchor, constant: 0)
        ])
        
        self.imageView = newImageView
        self.imageView?.backgroundColor = .red
        self.contentView.backgroundColor = .yellow
        
    }
    
    
    override func prepareForReuse() {
        imageView?.image = nil
    }
    
    var model: PhotoViewModel? {
        didSet {
            if let model = model {
                imageView?.image = nil
                
            }
        }
    }
}
