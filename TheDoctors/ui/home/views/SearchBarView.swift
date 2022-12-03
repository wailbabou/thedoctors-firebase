//
//  SearchBarView.swift
//  TheDoctors
//
//  Created by mac on 1/1/2022.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText : String
    @State private var showCancelButton: Bool = false
    @ObservedObject var homeVM: HomeViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("search", text: $searchText, onEditingChanged: { isEditing in
                self.showCancelButton = true
            }, onCommit: {
                print("onCommit")
                if !self.searchText.isEmpty {
                    self.homeVM.goToSearch = true
                }
            }).foregroundColor(.primary)
            
            Button(action: {
                self.searchText = ""
                
            }) {
                Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
            }
        }
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("Hello"), homeVM: HomeViewModel())
    }
}

// ....
extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
