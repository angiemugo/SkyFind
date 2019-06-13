//
//  API.swift
//  SkyFind
//
//  Created by Angie Mugo on 10/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import Foundation

enum API {
    case GetAirports
    case GetToken(clientID: String, clientSecret: String)
    case GetFlightSchedule(origin: String, destination: String, date: String, directFlights: Bool?)
}

extension API: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.lufthansa.com/v1/") else { fatalError("baseURL could not be configured")}
        return url
    }

    var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .GetAirports:
            return .Get

        case .GetToken:
            return .Post

        case .GetFlightSchedule:
            return .Get
        }
    }

    var path: String {
        switch self {
        case .GetAirports:
            return "references/airports"

        case .GetToken:
            return "oauth/token"

        case .GetFlightSchedule:
            return "operations/schedules"
        }
    }

    var task: HTTPTask {
        switch self {
        case .GetAirports:
            return .Request

        case .GetToken(let clientId, let secret):
            return .RequestFormEncoded(bodyParameters: ["client_id": clientId, "client_secret": secret, "grant_type": "client_credentials"])

        case .GetFlightSchedule(let origin, let destination, let date, let directFlights):
            return .RequestParametersAndHeaders(bodyParameters: ["origin": origin, "destination": destination, "fromDateTime": date, "directFlights": directFlights ?? false], urlParameters: nil, additionalHeaders: nil)
        }
    }
}
