//
//  Result.swift
//  AutoNation
//
//  Created by Gurleen Kaur on 2020-09-19.
//  Copyright © 2020 gurleen kaur. All rights reserved.
//

import Foundation

// Result Struct
struct Result: Decodable {
    let listings : [CarList]
}
// Car List data used by network manager to decode the data recived and view file to display the data
struct CarList: Decodable, Identifiable {
    let year : Int
    let model : String
    let make : String
    let trim : String
    let mileage : Int
    let listPrice : Int
    let images : Images
    let ownerHistory : OwnerHistory
    let dealer : Dealer
    let vin : String
    var id : String {
        return vin
    }
}
// Image Struct Can change the key to access other images; Currently just using the first image! can be optional.
struct Images: Decodable {
    let medium : [String?]
}

//Owner history used to decode the location of the car
struct OwnerHistory: Decodable {
    let history : [History]
}
// History Struct; May be the city can be nil so it an optional
struct History: Decodable {
    var city : String?
    var state : String
    let endOwnershipDate : String
    
}

// dealer to get hold of dealer's number to call.
struct Dealer: Decodable {
    let phone: String
}
