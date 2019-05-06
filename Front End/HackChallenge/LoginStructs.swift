//
//  LoginStructs.swift
//  HackChallenge
//
//  Created by Evan Azari on 5/4/19.
//  Copyright © 2019 Evan Azari. All rights reserved.
//

import Foundation

struct loginInfo: Codable{
    var session_token: String
    var session_expiration: String
    var update_token: String
}

struct accountDataResponse: Codable{
    var success: Bool
    var data: accountData
}

struct accountData: Codable{
    var id: Int
    var name: String
}
