//
//  Breakdown.swift
//  HackChallenge
//
//  Created by Evan Azari on 4/25/19.
//  Copyright © 2019 Evan Azari. All rights reserved.
//

import Foundation
import UIKit

class Breakdown{
    
    var account: String!
    var allColors: [color] = []
    var allGroups: [color]!
    var primaryColors: [color?] = []
    var secondaryColors: [color?] = []
    
    var avgLikes: Int = 0
    
    init(response: getResponse, account: String){
        for photo in response.data {
            for color in photo.colors{
                allColors.append(color)
            }
            
            avgLikes = avgLikes + photo.liked_by
        }
        
        allColors.sort(by:{ $0.score > $1.score})
        allGroups = group(sortedArray: allColors)
        
        if response.data.count == 0{
            avgLikes = 0
        }
        else{
            avgLikes = avgLikes/response.data.count
        }
        
        self.account = account
        
        for _ in 1...3 {
            primaryColors.append(popColor())
        }
        
        for _ in 1...9 {
            secondaryColors.append(popColor())
        }
        
    }
    
    func group(sortedArray: [color]) -> [color]{
        var array = sortedArray
        var returnArray: [color] = []
        let tolerance: CGFloat = 20
        
        while array.count != 0{
            var rgb = array[0].rgb
            var score = array[0].score
            array.remove(at: 0)
            
            var red: CGFloat = rgb[0]
            var green: CGFloat = rgb[1]
            var blue: CGFloat = rgb[2]
            var groupCount: CGFloat = 1
            
            var i = 0
            while i < array.count{
                if abs(rgb[0] - array[i].rgb[0]) < tolerance && abs(rgb[1] - array[i].rgb[1]) < tolerance && abs(rgb[2] - array[i].rgb[2]) < tolerance {
                    
                    red += array[i].rgb[0]
                    green += array[i].rgb[1]
                    blue += array[i].rgb[2]
                    score += array[i].score
                    groupCount += 1
                    
                    array.remove(at: i)
                }
                else{
                    i += 1
                }
            }
            
            red = red/groupCount
            green = green/groupCount
            blue = blue/groupCount
            
            returnArray.append(color(rgb: [red, green, blue], score: score, pixel_fraction: 0))
        }
        return returnArray.sorted(by: {$0.score > $1.score})
    }
    
    func popColor() -> color?{
        if allGroups.count == 0{
            return nil
        }
        else{
            return allGroups.remove(at: 0)
        }
    }
    
}

struct color: Codable {
    var rgb: [CGFloat]
    var score: Double
    var pixel_fraction: Double
}

struct photo: Codable {
    var url: String
    var liked_by: Int
    var colors: [color]
}

struct getResponse: Codable {
    var success: Bool
    var data: [photo]
}
