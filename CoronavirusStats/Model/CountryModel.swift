//
//  CountryModel.swift
//  CoronavirusStats
//
//

import Foundation

struct CountryModel : Decodable {
    
    let country: String
    let countryCode: String
    let province: String?
    let city: String?
    let cityCode: String?
    let lat : String
    let lon : String
    let confirmed: Int
    let deaths: Int
    let recovered: Int
    let active: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case province = "Province"
        case city = "City"
        case cityCode = "CityCode"
        case lat = "Lat"
        case lon = "Lon"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
}

