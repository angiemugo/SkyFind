//
//  Router.swift
//  SkyFind
//
//  Created by Angie Mugo on 10/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }

    func cancel() {
        self.task?.cancel()
    }

        fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
            var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
            request.httpMethod = route.httpMethod.rawValue
            do {
                switch route.task {
                case .Request:
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                case .RequestParameters(let bodyParameters,
                                        let urlParameters):
                    try self.configureParameters(bodyParameters: bodyParameters,
                                                 urlParameters: urlParameters,
                                                 request: &request)

                case .RequestParametersAndHeaders(let bodyParameters,
                                                  let urlParameters,
                                                  let additionalHeaders):
                    self.addAdditionalHeaders(additionalHeaders, request: &request)
                    try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)

                case .RequestFormEncoded(let bodyParameters):
                    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    request.httpBody = "client_id=\(bodyParameters["client_id"] ?? "")&client_secret=\(bodyParameters["client_secret"] ?? "")&grant_type=\("client_credentials")".data(using: .utf8)!
                }

                return request
            } catch {
                throw error
            }
        }

        fileprivate func configureParameters(bodyParameters: Parameters?,
                                             urlParameters: Parameters?,
                                             request: inout URLRequest) throws {
            do {
                if let bodyParameters = bodyParameters {
                    try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
                }
                if let urlParameters = urlParameters {
                    try JSONParameterEncoder.encode(urlRequest: &request, with: urlParameters)
                }

            } catch {
                throw error
            }
        }

    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
