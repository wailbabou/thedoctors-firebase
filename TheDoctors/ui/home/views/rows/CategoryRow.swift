//
//  CategoryRow.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import SwiftUI
import Kingfisher

struct CategoryRow: View {
    var category : Category
    var body: some View {
        VStack {
            VStack {
                VStack(alignment: .center){
                    KFImage(URL(string: category.iconUrl))
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                    HStack{
                        Text(category.name)
                            .font(.body)
                            .foregroundColor(Color("welcome_background"))
                        //Spacer()
                    }
                }
                .padding()
            }.background(Color("whiteColor"))
        }.cornerRadius(20)
            .shadow(radius: 0.5)
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(category: Category(id : "id1",name: "Dental surgeon", iconUrl: "https://i.imgur.com/1vnjzN3.png"))
    }
}
