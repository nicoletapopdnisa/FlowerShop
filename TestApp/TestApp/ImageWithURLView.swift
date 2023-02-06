//
//  ImageWithURLView.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 29.01.2023.
//

import SwiftUI

struct ImageWithURLView: View {
    var urlString: String
    @ObservedObject var imageLoader = ImageLoader()
    @State var image = UIImage(systemName: "heart.fill")!

    var body: some View {
        VStack() {
            Image(uiImage: image)
                .resizable()
                .onReceive(imageLoader.$data) { data in
                    guard let data = data else { return }
                    self.image = UIImage(data: data) ?? UIImage()
                }
        }.onAppear {
            self.imageLoader.loadData(from: urlString)
        }
    }
}
