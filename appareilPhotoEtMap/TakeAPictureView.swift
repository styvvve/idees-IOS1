//
//  TakeAPictureView.swift
//  appareilPhotoEtMap
//
//  Created by NGUELE Steve  on 02/01/2025.
//

import SwiftUI

struct TakeAPictureView: View {
    
    @State private var showCamera = false
    @State private var image: Image?
    
    var body: some View {
        VStack {
            Button {
                showCamera = true
            }label: {
                Image(systemName: "camera.fill")
                    .foregroundStyle(.black)
                    .font(.system(size: 30))
                    .padding(30)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(Circle())
            }
        }.sheet(isPresented: $showCamera, content: {
            CameraView { pickedImage in
                if let uiImage = pickedImage {
                    image = Image(uiImage: uiImage)
                }
                showCamera = false
            }
        })
    }
}

#Preview {
    TakeAPictureView()
}
