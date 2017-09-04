//
//  ShopResult.swift
//  CafeNomad
//
//  Created by Vince Lee on 2017/8/25.
//  Copyright © 2017年 Vince Lee. All rights reserved.
//

import Foundation

struct Shop: Codable {
    var id: String?
    var name: String?
    var city: String?
    var wifi: Double?
    var seat: Double?
    var quiet: Double?
    var tasty: Double?
    var cheap: Double?
    var music: Double?
    var url: String?
    var address: String?
    var latitude: String?
    var longitude: String?
    var limited_time: String?
    var socket: String?
    var standing_desk: String?
    var mrt: String?
    var open_time: String?
    
    
}

struct PropertyKeys {
    static let placesCell = "PlacesCell"
    static let placesSegue = "PlacesSegue"
    static let unwindToPlaces = "UnwindToPlaces"
}

