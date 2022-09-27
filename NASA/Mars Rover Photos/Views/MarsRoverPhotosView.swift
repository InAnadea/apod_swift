//
//  MarsRoverPhotosView.swift
//  NASA
//
//  Created by Ivan Nazarov on 22.09.2022.
//

import SwiftUI

struct MarsRoverPhotosView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        List {
            ForEach(self.viewModel.roverPhotos.photos, id: \.id) { photo in
                AsyncImage(url: URL(string: photo.img_src)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                        
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    case .failure(let error):
                        Text(error.localizedDescription)
                        
                    @unknown default:
                        EmptyView()
                    }
                }
                .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            }
            
            if viewModel.roverPhotos.photos.isEmpty && viewModel.isLastPage {
                Text("There is no rover photos")
            }
            
            if !viewModel.isLastPage {
                ProgressView()
                    .onAppear(perform: { viewModel.getNextPage() })
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle(Text("Mars rover photos"))
    }
}

struct MarsRoverPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        MarsRoverPhotosView()
    }
}
