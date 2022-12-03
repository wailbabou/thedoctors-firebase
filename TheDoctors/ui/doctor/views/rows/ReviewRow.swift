//
//  ReviewRow.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import SwiftUI

struct ReviewRow: View {
    var review : Review
    var body: some View {
        VStack {
            HStack{
                Spacer()
                VStack{
                    Text(review.reviewer)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text(review.review)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                    Text("\(review.stars)")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .padding(.horizontal,8)
                .padding(.vertical , 5)
                .overlay(
                    Capsule()
                        .stroke(Color.white, lineWidth: 1)
                )
            }
            
        }.padding(.horizontal)
    }
}

struct ReviewRow_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRow(review : PreviewData.review).background(.blue)
    }
}
