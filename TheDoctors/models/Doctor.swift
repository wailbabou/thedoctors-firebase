//
//  Doctor.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import Foundation
struct Doctor : Codable {
    let id : String
    let about : String
    let address : String
    let fullname : String
    let image : String
    let openHours : String
    let category : String
    let reviews : [Review]?
    let avgRating : Double?
    let countRates : Double?
    let plusCode : String?
}
