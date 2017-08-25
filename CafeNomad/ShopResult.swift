//
//  ShopResult.swift
//  CafeNomad
//
//  Created by Vince Lee on 2017/8/25.
//  Copyright © 2017年 Vince Lee. All rights reserved.
//

import Foundation

struct Shop: Codable {
    var id: String
    var name: String
    var city: String
    var wifi: Int
    var seat: Int
    var quiet: Int
    var tasty: Int
    var cheap: Int
    var music: Int
    var url: URL?
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var limited_time: String?
    var socket: String?
    var standing_desk: String?
    var mrt: String?
    var open_time: String?
    
    
}


