//
//  TokenModel.swift
//  SkyFind
//
//  Created by Angie Mugo on 10/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import Foundation

struct TokenModel {
    var access_token: String
    var token_type: String
    var validity_period: String
}

extension TokenModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case AccessToken = "access_token"
        case TokenType = "token_type"
        case ValidityPeriod = "expires_in"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        access_token = try container.decode(String.self, forKey: .AccessToken)
        token_type = try container.decode(String.self, forKey: .TokenType)
        validity_period = try container.decode(String.self, forKey: .ValidityPeriod)
    }

    init(from data: Data) throws {
        self = try JSONDecoder().decode(TokenModel.self, from: data)
    }
}
