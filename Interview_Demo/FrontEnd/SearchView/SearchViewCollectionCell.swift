//
//  SearchViewCollectionCell.swift
//  Interview_Demo
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import UIKit

typealias CancelButtonCallBack = ((_ photo: PhotoViewModel) -> Void)

final class SearchViewCollectionCell: UICollectionViewCell {

    weak var imageView: UIImageView?
    weak var indicator: UIActivityIndicatorView?
    weak var progressView: UIStackView?
    let localize: SearchViewLocalizeStrings = SearchViewLocalizeStrings()
    var model : PhotoViewModel?
    
    struct Constants {
        static let imageMargin: CGFloat = 5.0
        static let progressStackSpacing: CGFloat = 5.0
        static let placeHolderImageName = "placeholder"
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
        
        let progressView = UIStackView()
        progressView.spacing = Constants.progressStackSpacing
        progressView.axis = .vertical

        let indicator = UIActivityIndicatorView(style: .medium)
        self.indicator = indicator
        
        progressView.addArrangedSubview(indicator)
        
        self.contentView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.centerYAnchor.constraint(equalTo: progressView.centerYAnchor, constant: 0),
            self.contentView.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: -10),
            self.contentView.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 10),
        ])
        progressView.isHidden = true
        
        self.progressView = progressView
    }
    
    override func prepareForReuse() {
        imageView?.image = UIImage(named: Constants.placeHolderImageName)
        self.model = nil
    }
    
    func startProgress() {
        self.progressView?.isHidden = false
        self.indicator?.startAnimating()
    }
    
    func stopProgress() {
        self.progressView?.isHidden = true
        self.indicator?.stopAnimating()
    }
}
