//
//  CountryNameModel.swift
//  CoronavirusStats


import Foundation

struct CountryListModel : Decodable {
    
    let country: String
    let ISO2: String
    let slug: String?
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case ISO2 = "ISO2"
        case slug = "Slug"
        
    }
    
    init(country: String, ISO2: String, slug: String?) {
        self.country = country
        self.ISO2 = ISO2
        self.slug = slug
    }
}



