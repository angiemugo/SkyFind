//
//  EndPointType.swift
//  SkyFind
//
//  Created by Angie Mugo on 10/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders { get }
}
