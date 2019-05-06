//
//  NetworkManager.swift
//  HackChallenge
//
//  Created by Evan Azari on 5/1/19.
//  Copyright © 2019 Evan Azari. All rights reserved.
//

import Foundation
import Alamofire

let endpoint = "http://34.73.120.45/api/"
let registerEndpoint = "\(endpoint)register/"
let loginEndpoint = "\(endpoint)login/"
let updateEndpoint = "\(endpoint)session/"
let userEndpoint = "\(endpoint)users/"
let colorEndpoint = "\(endpoint)colors/"

class NetworkManager {
    
    var loadingDelegate: failedLoad!
    
    static func register(email: String, password: String, completion: @escaping (loginInfo) -> Void){
        let u: [String: Any] = ["email": email, "password": password]
        var tokens = loginInfo(session_token: "", session_expiration: "", update_token: "")
        
        Alamofire.request(registerEndpoint, method: .post, parameters: u, encoding: JSONEncoding.default).validate().responseData { (response) in
            
            switch response.result{
            case .success(let data):
                let json = JSONDecoder()
                
                if let login = try? json.decode(loginInfo.self, from: data){
                    tokens = login
                }
                else{
                    tokens.session_token = "exists"
                }
                completion(tokens)
            case .failure(let error):
                tokens.session_token = "failure"
                print(error.localizedDescription)
                completion(tokens)
            }
        }
    }
    
    static func login(email: String, password: String, completion: @escaping (loginInfo) -> Void){
        let u: [String: Any] = ["email": email, "password": password]
        var tokens = loginInfo(session_token: "failure", session_expiration: "", update_token: "")
        
        Alamofire.request(loginEndpoint, method: .post, parameters: u, encoding: JSONEncoding.default).validate().responseData { (response) in
            
            
            
            switch response.result{
            case .success(let data):
                
                let json = JSONDecoder()
                if let login = try? json.decode(loginInfo.self, from: data){
                    tokens = login
                    print("if let")
                }
                else{
                    tokens.session_token = "invalid"
                }
                completion(tokens)
            case .failure:
                completion(tokens)
            }
        }
    }
    
    static func updateSession(){
    }
    
    static func getUser(user: loginInfo, completion: @escaping (User) -> Void){
        let h: HTTPHeaders = ["Authorization": user.session_token]
        
        Alamofire.request(userEndpoint, method: .get, encoding: URLEncoding.default, headers: h).validate().responseData { response in
            
            switch response.result{
            case .success(let data):
                
                let json = JSONDecoder()
                if let r = try? json.decode(User.self, from: data){
                    print("User successfully retrieved")
                    completion(r)
                }
                else{
                    print("could not conform")
                }
            case .failure:
                print("Could not retrieve user! (error)")
            }
        }
    }
    
    static func addAccount(account: String, user: loginInfo){
        let p: [String: Any] = ["name": account]
        let h: HTTPHeaders = ["Authorization": user.session_token]
        
        Alamofire.request(userEndpoint, method: .post, parameters: p, encoding: JSONEncoding.default, headers: h).validate().responseData { (response) in
            
            switch response.result{
            case .success(let data):
                let json = JSONDecoder()
                if let acct = try? json.decode(accountDataResponse.self, from: data){
                    print("save successeful")
                }
                else{
                    print("no error but didnt save")
                }
            case .failure(let error):
                print("save error: \(error.localizedDescription)")
            }
        }
    }
    
    static func deleteAccount(account: String, user: loginInfo, completion: @escaping ()->Void){
        let h: HTTPHeaders = ["Authorization": user.session_token]
        
        Alamofire.request("\(userEndpoint)\(account)/", method: .delete, headers: h).validate().responseData { (response) in
            
            switch response.result{
            case .success(let data):
                let json = JSONDecoder()
                
                if let acct = try? json.decode(accountDataResponse.self, from: data){
                    print("delete successeful")
                    completion()
                }
                else{
                    print("no error but didnt delete")
                }
            case .failure(let error):
                print("delete error: \(error.localizedDescription)")
            }
        }
    }
    
    func getColors(account: String, completion: @escaping (Breakdown) -> Void){
        print("\(colorEndpoint)\(account)/")
        
        Alamofire.request("\(colorEndpoint)\(account)/", method: .get, encoding: URLEncoding.default).validate().responseData { (response) in
            
            switch response.result {
            case .success(let data):
                let json = JSONDecoder()
                
                if let info = try? json.decode(getResponse.self, from: data){
                    let b = Breakdown(response: info, account: account)
                    completion(b)
                }
                else{
                    self.loadingDelegate.fail()
                }
                print("HALLELUYAH")
            case .failure(let error):
                print("This is the error:\n" + error.localizedDescription)
                self.loadingDelegate.fail()
            }
        }

    }
}
