//
//  ImagePicker.swift
//  TheDoctors
//
//  Created by mac on 3/1/2022.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @Binding var selectedImage: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var selectedImage: UIImage?
        
        init(presentationMode: Binding<PresentationMode>,selectedImage: Binding<UIImage?>) {
            _presentationMode = presentationMode
            _selectedImage = selectedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            var uiImage:UIImage?
            if let img = info[.editedImage] as? UIImage{
                uiImage = img
            }
            else if let img = info[.originalImage] as? UIImage{
                uiImage = img
            }

            selectedImage = uiImage!
            presentationMode.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, selectedImage: $selectedImage)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        //picker.allowsEditing = true

        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
}

