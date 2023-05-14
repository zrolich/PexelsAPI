//
//  ViewController.swift
//  PexelsAPI
//
//  Created by Zhanna Rolich on 14.12.2022.
//

import UIKit
import Kingfisher

class GalleryViewController: UIViewController {
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ImageCell.self, forCellWithReuseIdentifier: String(describing: ImageCell.self))
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var gallery = [Photo]()
    var timer: Timer?
    var currentPage = 1
    var totalPage = 1
    var querySearch: String = ""
    
    let itemPerRow: CGFloat = 3
    let sectionInserts = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15 )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setupDelegates()
        navigationItem.searchController = searchController
        
        
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    private func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
        
    private func fetchImages(typeOfQuery: String) {
        
        NetworkDataFetch.shared.searchImage(query: typeOfQuery, page: currentPage) {[weak self] galleryModel, error in
            if error == nil {
                guard let galleryModel = galleryModel else {return}
                self?.gallery = galleryModel.photos
                self?.collectionView.reloadData()
                self?.totalPage = Int(galleryModel.total_results/perPage)
            }
        }
    }
}

extension GalleryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.querySearch = searchText
                self?.fetchImages(typeOfQuery: searchText)
            })
        }
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth/itemPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCell.self), for: indexPath) as! ImageCell
        
        let photo = gallery[indexPath.item].src
        let imageURL = URL(string: photo.small)
        cell.photoImage.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { result in
            cell.setNeedsLayout()
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imagesViewController = ImagesViewController()
        let selectPhotoUrl = gallery[indexPath.item].src.medium
        imagesViewController.urlPhoto = selectPhotoUrl
        let selectPhotoText = gallery[indexPath.item].alt
        imagesViewController.photoText = selectPhotoText
        navigationController?.pushViewController(imagesViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if currentPage < totalPage && indexPath.item >= gallery.count - 6 {
            currentPage = currentPage + 1
            NetworkDataFetch.shared.searchImage(query: querySearch, page: currentPage) {[weak self] galleryModel, error in
                if error == nil {
                    guard let galleryModel = galleryModel else {return}
                    self?.gallery.append(contentsOf: galleryModel.photos)
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}

extension GalleryViewController {
    
    private func setConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}
