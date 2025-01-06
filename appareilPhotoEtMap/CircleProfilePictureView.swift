//
//  CircleProfilePictureView.swift
//  appareilPhotoEtMap
//
//  Created by NGUELE Steve  on 05/01/2025.
//

import SwiftUI
import PhotosUI

struct CircleProfilePictureView: View {
    
    //afficher la camera qd on appuie sur la photo de profil
    @Binding var showCamera: Bool
    @Binding var confirmationShow: Bool
    
    //pour sélectionner la photo depuis la librairie
    @Binding var isPhotoPickerPresented: Bool
    @Binding var pickerItem: PhotosPickerItem?
    
    //variable locale pr travailler
    @State private var defaultImage: Image? = Image("default_image")
    
    var body: some View {
        VStack {
            Button {
                confirmationShow.toggle()
            }label: {
                ZStack {
                    defaultImage!
                        .resizable()
                        .clipShape(Circle())
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                    VisualEffectView(effect: UIBlurEffect(style: .dark))
                        .frame(width: 120, height: 120)
                        .edgesIgnoringSafeArea(.all)
                        .offset(y: 80)
                        .overlay(
                            Text("Change")
                                .font(.system(size: 12))
                                .foregroundStyle(.white)
                                .offset(y: 35),
                            alignment: .center
                        )
                }
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .navigationTitle("Settings")
                .confirmationDialog(
                    "Changement de photo",
                    isPresented: $confirmationShow
                ) {
                    Button("Importer depuis la librairie") {
                        isPhotoPickerPresented = true
                    }
                    Button("Prendre une photo") {
                        showCamera = true
                    }
                }
            }.photosPicker(
                isPresented: $isPhotoPickerPresented,
                selection: $pickerItem,
                matching: .images
            )
            .onChange(of: pickerItem) {
                Task {
                    defaultImage = try await pickerItem?.loadTransferable(type: Image.self)
                }
            }
            .sheet(isPresented: $showCamera, content: {
                CameraView { pickedImage in
                    if let uiImage = pickedImage {
                        defaultImage = Image(uiImage: uiImage)
                    }
                    showCamera = false
                }
            })
        }
    }
}

#Preview {
    CircleProfilePictureView(showCamera: .constant(false), confirmationShow: .constant(false), isPhotoPickerPresented: .constant(false), pickerItem: .constant(nil))
}
