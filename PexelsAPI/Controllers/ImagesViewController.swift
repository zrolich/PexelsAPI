//
//  ImageViewController.swift
//  PexelsAPI
//
//  Created by Zhanna Rolich on 15.12.2022.
//

import UIKit

class ImagesViewController: UIViewController {
    
    var urlPhoto: String?
    var photoText: String?
    
    private let fullScreenImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setupFullScreenPhoto()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(fullScreenImage)
        self.title = photoText
    }
    
    func initImage(){
        
    }
    
    func setupFullScreenPhoto(){
        let imageURL = URL(string: urlPhoto!)
        self.fullScreenImage.kf.indicatorType = .activity
        self.fullScreenImage.kf.setImage(with: imageURL, placeholder: nil, options: [.transition(.fade(0.5))], progressBlock: nil, completionHandler: { result in
        })
    }
}

extension ImagesViewController {
    
    private func setConstraints() {

        NSLayoutConstraint.activate([
            fullScreenImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            fullScreenImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            fullScreenImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            fullScreenImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

