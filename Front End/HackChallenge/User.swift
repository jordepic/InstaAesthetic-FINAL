//
//  User.swift
//  HackChallenge
//
//  Created by Evan Azari on 5/4/19.
//  Copyright © 2019 Evan Azari. All rights reserved.
//

import Foundation

struct User: Codable{
    var success: Bool
    var data: UserData
}

struct UserData: Codable{
    var id: Int
    var email: String
    var accounts: [UserAccount]
}

struct UserAccount: Codable{
    var id: Int
    var name: String
}
