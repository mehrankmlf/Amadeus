//
//  FlightSearchResponse.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 1/13/22.
//

import Foundation

// MARK: - Welcome
struct FlightSearchResponse: Decodable {
    var data: [DataResponse]?
    var dictionaries: Dictionaries?
    var meta: Meta?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case dictionaries = "dictionaries"
        case meta = "meta"
    }
}

struct DataResponse: Decodable {
    var type, origin, destination, departureDate: String?
    var returnDate: String?
    var price: Price?
    var links: DatumLinks?
    
     init(type : String, origin: String, destination: String, departureDate: String, returnDate: String, price: Price, links : DatumLinks) {
        self.type = type
        self.origin = origin
        self.destination = destination
        self.departureDate = departureDate
        self.returnDate = returnDate
        self.price = price
        self.links = links
    }
}

struct DatumLinks: Decodable {
    var flightDates, flightOffers: String?
}

struct Price: Decodable {
    var total: String?
}

struct Dictionaries: Decodable {
    var currencies: Currencies?
}

struct Currencies: Decodable {
    var usd: String?
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - Location
struct Location: Decodable {
    var subType, detailedName: String?
}

// MARK: - Meta
struct Meta: Decodable {
    var currency: String?
    var links: MetaLinks?
    var defaults: Defaults?
}

// MARK: - Defaults
struct Defaults: Decodable {
    var departureDate: String?
    var oneWay: Bool?
    var duration: String?
    var nonStop: Bool?
    var viewBy: String?
}

// MARK: - MetaLinks
struct MetaLinks: Decodable {
    var linksSelf: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

