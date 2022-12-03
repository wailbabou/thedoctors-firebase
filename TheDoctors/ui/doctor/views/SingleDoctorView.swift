//
//  SingleDoctorView.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import SwiftUI
import Kingfisher
import MapKit
import OpenLocationCode

struct SingleDoctorView: View {
    @Binding var showCard : Bool
    @Binding var showContent : Bool

    var doctor : Doctor
    var animation : Namespace.ID
    @StateObject var doctorVM = SingleDoctorViewModel()
    var isAdmin : Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.spring()){
                            showCard.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation(.easeIn){
                                    showContent = false
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                    }.overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 2))
                        .padding()
                }
                
                KFImage(URL(string: doctor.image))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .matchedGeometryEffect(id: "image-\(doctor.id)", in: animation)
                    .padding()
                
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
                
                HStack(alignment: .top){
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        if doctor.avgRating != nil {
                            Text(String(format: "%.2f", doctor.avgRating!))
                                .font(.caption)
                                .foregroundColor(.white)
                        }else{
                            Text("N/A").font(.caption)
                        }
                    }
                    .padding(.horizontal,8)
                    .padding(.vertical , 5)
                    .overlay(
                        Capsule()
                            .stroke(Color.white, lineWidth: 1)
                    )
                }.matchedGeometryEffect(id: "rate-\(doctor.id)", in: animation)
                Divider().padding()
                Group {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.white)
                        Text(doctor.address)
                            .foregroundColor(.white)
                    }.padding(5)
                    HStack {
                        Image(systemName: "timer")
                            .foregroundColor(.white)
                        Text(doctor.openHours)
                            .foregroundColor(.white)
                    }.padding(5)
                    Button {
                        if doctor.plusCode == nil {
                            return
                        }
                        if let coord = OpenLocationCode.decode(doctor.plusCode!) {
                            let coordinate = CLLocationCoordinate2DMake(coord.latitudeCenter,coord.longitudeCenter)
                            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
                            mapItem.name = doctor.fullname
                            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
                        }

                    } label: {
                        HStack {
                            Image(systemName: "map.fill")
                                .foregroundColor(Color("welcome_background"))
                            Text("Open in Maps")
                                .foregroundColor(Color("welcome_background"))
                        }.padding()
                    }.background(Color.white)
                        .clipShape(Capsule())
                }
                Divider().padding()
                if isAdmin {
                    HStack {
                        Button {
                            self.doctorVM.approveDoctor(secretKey: "") {
                                // done
                                withAnimation(.spring()){
                                    showCard.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn){
                                            showContent = false
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text("Approve")
                                    .font(.callout)
                                    .foregroundColor(Color("welcome_background"))
                            }.padding()
                        }.background(Color.white)
                            .clipShape(Capsule())
                            .padding(.trailing)
                        Button {
                            self.doctorVM.declineDoctor(secretKey: "") {
                                // done
                                withAnimation(.spring()){
                                    showCard.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn){
                                            showContent = false
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text("Decline")
                                    .font(.callout)
                                    .foregroundColor(Color.white)
                            }.padding()
                        }.background(Color.red)
                            .clipShape(Capsule())
                            .padding(.trailing)
                    }.padding(.bottom)
                }else {
                    // user ...
                    Group {
                        HStack {
                            Spacer()
                            Button {
                                self.doctorVM.sheetAddRate = true
                            } label: {
                                HStack {
                                    Text("Add Review")
                                        .font(.callout)
                                        .foregroundColor(Color("welcome_background"))
                                }.padding(.horizontal)
                                    .padding(.vertical,4)
                            }.background(Color.white)
                                .clipShape(Capsule())
                                .padding(.trailing)
                        }
                        ForEach(doctorVM.reviews , id: \.id){ review in
                            ReviewRow(review: review)
                                .padding(.leading,3)
                                .padding(.vertical)
                                .shadow(radius: 2)
                                .transition(AnyTransition.scale)
                        }
                        Spacer()
                    }
                }
            }.onAppear {
                self.doctorVM.getReviews(doctor: doctor)
            }.sheet(isPresented: self.$doctorVM.sheetAddRate) {
                AddReviewView(doctorVM: self.doctorVM, isActive: self.$doctorVM.sheetAddRate)
            }
        }
        .background(Color("welcome_background").matchedGeometryEffect(id: "bgColor-\(doctor.id)", in: animation))
        .cornerRadius(40, corners: [.topLeft, .topRight])
        .ignoresSafeArea(edges:.bottom)
    }
}

struct SingleDoctorView_Previews: PreviewProvider {
    static var previews: some View {
        SingleDoctorView(showCard : .constant(true), showContent : .constant(true),doctor: PreviewData.doctor,animation: Namespace.init().wrappedValue)
    }
}
