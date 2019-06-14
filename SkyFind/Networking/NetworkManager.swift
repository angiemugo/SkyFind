//
//  NetworkManager.swift
//  SkyFind
//
//  Created by Angie Mugo on 10/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

struct NetworkManager {
    private let router = Router<API>()

    enum NetworkResponse: String {
        case success
        case authenticationError = "You need to be authenticated first"
        case badRequest = "Bad request"
        case outdated = " The url you requested is outdated"
        case failed = "Network request failed"
        case noData = "Response returned with no data to decode"
        case unableToDecode = "We could not decode the response"
    }

    enum Result<String> {
        case success
        case failure(String)
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 400...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.failed.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }

    func getToken(_ clientId: String, secret: String, completion: @escaping (_ response: TokenModel?, _ error: String?) -> ()) {
        router.request(.GetToken(clientID: clientId, clientSecret: secret)) { data, response, error  in
            if error != nil {
                completion(nil, "Please check your network connection")
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }

                    do {
                        let apiResponse = try TokenModel(from: responseData)
                        completion(apiResponse, nil)
                    } catch let error {
                        completion(nil, error.localizedDescription)
                    }

                case .failure(let error):
                 completion(nil, error)
                }
            }
        }
    }

    func getAirports(completion: @escaping (_ response: [Airport]?, _ error: String?) -> ()) {
        guard let token = KeychainWrapper.standard.string(forKey: "token") else {
            return
            //implement logic to kick off fetching the token
        }

        router.request(.GetAirports(token: token)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection")
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }

                    do {
                        let apiResponse = try AirportResponse(from: responseData)
                        completion(apiResponse.airportResource.airports.airport, nil)
                    } catch let error {
                        completion(nil, error.localizedDescription)
                    }

                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }

    func getSchedule(_ origin: String, destination: String, date: String, completion: @escaping (_ flightSchedule: ScheduleResource?, _ error: String?) -> ()) {
        guard let token = KeychainWrapper.standard.string(forKey: "token") else {
            return
            //implement logic to kick off fetching the token
        }

        router.request(.GetFlightSchedule(token: token, origin: origin, destination: destination, date: date)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection")
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }

                    do {
//                        let apiResponse = try ScheduleResource(from: responseData)
                        let apiResponse = try JSONDecoder().decode(ScheduleResource.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch let error {
                        completion(nil, error.localizedDescription)
                    }

                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
}
