//
//  PreviewData.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import Foundation

class PreviewData {
    static let doctor = Doctor(id: "id", about: "Hello this is DR Frarah", address: "Montreal , Canada", fullname: "Farah Farasha", image: "https://i.imgur.com/nitU0I7.png", openHours: "8:00 - 16:00",category:"Heart Surgoen", reviews : [review,review,review], avgRating: 5.0,countRates:2, plusCode: "849VCWC8+Q48")
    static let review = Review(id : "id" , review: "hello , this is my review about this doctor", reviewer: "Wail", stars: 5)
    static let category = Category(id: "id", name: "category", iconUrl: "iconUrl")
}
