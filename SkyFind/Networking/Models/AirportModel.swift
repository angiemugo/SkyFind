//
//  AirportModel.swift
//  SkyFind
//
//  Created by Angie Mugo on 10/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import Foundation

struct AirportResponse {
    var airportResource: AirportResource
}

extension AirportResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case AirportResource = "AirportResource"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        airportResource = try container.decode(AirportResource.self, forKey: .AirportResource)
    }

    init(from data: Data) throws {
        self = try JSONDecoder().decode(AirportResponse.self, from: data)
    }
}

struct AirportResource {
    var airports: Airports
}

extension AirportResource: Decodable {
    enum CodingKeys: String, CodingKey {
        case Airports = "Airports"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        airports = try container.decode(Airports.self, forKey: .Airports)
    }
}

struct Airports {
    var airport: [Airport]
}

extension Airports: Decodable {
    enum CodingKeys: String, CodingKey {
        case Airport = "Airport"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        airport = try container.decode([Airport].self, forKey: .Airport)
    }
}

struct Airport {
    var airportCode: String
    var position: Position
    var name: Names
    var location: String
}

extension Airport: Decodable {
    enum CodingKeys: String, CodingKey {
        case AirportCode = "AirportCode"
        case Position = "Position"
        case Names = "Names"
        case Location = "TimeZoneId"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        airportCode = try container.decode(String.self, forKey: .AirportCode)
        position = try container.decode(Position.self, forKey: .Position)
        name = try container.decode(Names.self, forKey: .Names)
        location = try container.decode(String.self, forKey: .Location)
    }
}

struct Position {
    var coordinate: Coordinate
}

extension Position: Decodable {
    enum CodingKeys: String, CodingKey {
        case Coordinate = "Coordinate"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        coordinate = try container.decode(Coordinate.self, forKey: .Coordinate)
    }
}

struct Coordinate {
    var longitude: Double
    var latitude: Double
}

extension Coordinate: Decodable {
    enum CodingKeys: String, CodingKey {
        case Longitude = "Latitude"
        case Latitude = "Longitude"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        longitude = try container.decode(Double.self, forKey: .Longitude)
        latitude = try container.decode(Double.self, forKey: .Latitude)
    }
}

struct Names {
    var name: [Name]
}

extension Names: Decodable {
    enum CodingKeys: String, CodingKey {
        case Name = "Name"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode([Name].self, forKey: .Name)
    }
}

struct Name {
    var airportName: String
}

extension Name: Decodable {
    enum CodingKeys: String, CodingKey {
        case AirportName = "$"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        airportName = try container.decode(String.self, forKey: .AirportName)
    }
}
