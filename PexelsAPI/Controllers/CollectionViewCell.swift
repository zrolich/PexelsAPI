//
//  Cell.swift
//  PexelsAPI
//
//  Created by Zhanna Rolich on 19.12.2022.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(photoImage)
        photoImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        photoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

