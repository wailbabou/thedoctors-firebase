//
//  ContentView.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var sharedVM : SharedViewModel
    var body: some View {
        if sharedVM.goToHome {
            HomeView()
        }else if sharedVM.goToAdmin{
            AdminLoginView()
        }else{
            WelcomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
