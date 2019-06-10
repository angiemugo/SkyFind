//
//  HTTPTask.swift
//  SkyFind
//
//  Created by Angie Mugo on 10/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case Request
    case RequestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case RequestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)
}

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    case ParametersNil = "Parameters were nil"
    case EncodingFailed = "Parameter encoding failed"
    case MissingURL = "URL is nil"
}
