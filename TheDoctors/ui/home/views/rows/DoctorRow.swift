//
//  DoctorRow.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import SwiftUI
import Kingfisher

struct DoctorRow: View {
    var doctor : Doctor
    var animation: Namespace.ID
    var fullWidth : Bool = false

    var body: some View {
        VStack {
            VStack {
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text(doctor.fullname)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(.bottom,3)
                            .matchedGeometryEffect(id: "fullname-\(doctor.id)", in: animation)
                        
                        Text(doctor.category)
                            .font(.body)
                            .foregroundColor(Color.white)
                            .matchedGeometryEffect(id: "category-\(doctor.id)", in: animation)
                        
                    }.padding()
                    HStack(alignment: .top){
                        HStack {
                            Image(systemName: "star.fill")
                                .resizable()
                                .foregroundColor(.white)
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                            if doctor.avgRating != nil{
                                Text( String(format: "%.2f", doctor.avgRating!))
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }else{
                                Text("N/A")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal,8)
                        .padding(.vertical , 5)
                        .overlay(
                            Capsule()
                                .stroke(Color.white, lineWidth: 1)
                        ).padding()
                            .matchedGeometryEffect(id: "rate-\(doctor.id)", in: animation)
                        if fullWidth {
                            Spacer()
                        }
                        KFImage(URL(string: doctor.image))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                            .matchedGeometryEffect(id: "image-\(doctor.id)", in: animation)
                    }
                }
            }.background(Color("welcome_background").matchedGeometryEffect(id: "bgColor-\(doctor.id)", in: animation))
        }.cornerRadius(20)
    }
}

struct DoctorRow_Previews: PreviewProvider {
    static var previews: some View {
        DoctorRow(doctor: PreviewData.doctor, animation: Namespace.init().wrappedValue)
    }
}
