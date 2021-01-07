//
//  CoronavirusStats

import Foundation

struct CountryData: Codable {
    
    let global: Global
    let countries: [Countries]
}

struct Global: Codable{
    let newConfirmed: Double
    let totalConfirmed: Double
    let newDeaths: Double
    let newCovered: Double
    let totalRecovered: Double

    enum CodingKeys: String, CodingKey {
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case newCovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
}

struct Countries: Codable {
    let country: String
    let countryCode: String
    let newConfirmedCountry: Double
    let newDeathsCountry: Double
    let totalDeathsCountry: Double
    let newRecoveredCountry: Double
    let totalRecoveredCountry: Double
    let date: Date

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case newConfirmedCountry = "NewConfirmed"
        case newDeathsCountry = "NewDeaths"
        case totalDeathsCountry = "TotalDeaths"
        case newRecoveredCountry =  "NewRecovered"
        case totalRecoveredCountry = "TotalRecovered"
        case date = "Date"
    }
}


/**
 
 
 
 
 
 
 
 
 
 
 
 
 DATA YAPISINA GÖRE KUR
 
 
 https://medium.com/@resulsilay/swift-ile-alamofire-ve-swiftyjson-kullan%C4%B1m%C4%B1-54021ef0c1a0
 
 
 
 
 
 
 
 
 
 
 */


