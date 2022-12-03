//
//  Review.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import Foundation
struct Review : Codable {
    let id : String
    let review : String
    let reviewer : String
    let stars : Int
}
