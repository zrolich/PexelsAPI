//
//  GalleryModel.swift
//  PexelsAPI
//
//  Created by Zhanna Rolich on 19.12.2022.
//

import Foundation

struct GalleryModel: Decodable {
    let total_results: Int
    let photos: [Photo]
}

struct Photo: Decodable {
    let src: Source
    let alt: String
}

struct Source: Decodable {
    let original: String
    let large: String
    let medium: String
    let small: String
    let tiny: String
    let portrait: String
    let landscape: String
}
