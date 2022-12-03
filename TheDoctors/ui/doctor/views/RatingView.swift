//
//  RatingView.swift
//  TheDoctors
//
//  Created by mac on 2/1/2022.
//

import Foundation
import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var onClick : ((_ clicked : Bool) -> Void)? = nil
    
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color("welcome_background")
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    var body: some View {
        HStack(alignment: .center , spacing: 0) {
            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .resizable()
                    .frame(width: 40 , height: 40)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .padding(/*@START_MENU_TOKEN@*/.all, 0.0/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        self.rating = number
                    }
            }
        }
    }
}
