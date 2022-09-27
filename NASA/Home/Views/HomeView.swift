//
//  HomeView.swift
//  NASA
//
//  Created by Ivan Nazarov on 26.09.2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = ViewModel()

    
    var body: some View {
            VStack {
                if let apod = viewModel.currentApod {
                    VStack {
                        HStack {
                            Text("Astronomy Picture of the Day")
                            Spacer()
                            NavigationLink {
                                APODView()
                            } label: {
                                Text("More")
                            }
                        }
                        .padding()
                        if let url = apod.hdurl {
                            AsyncImage(url: URL(string: url)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                    
                                case .success(let image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                    
                                case .failure:
                                    Image(systemName: "photo")
                                    
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
                if let photos = viewModel.roverPhotos?.photos {
                    VStack(alignment: .trailing) {
                        HStack {
                            Text("Mars rover photos")
                            Spacer()
                            NavigationLink {
                                MarsRoverPhotosView()
                            } label: {
                                Text("More")
                            }
                        }
                        .padding()
                        ScrollView(.horizontal) {
                            HStack(spacing: 20) {
                                ForEach(photos) { photo in
                                    RoverPhotoView(photo: photo)
                                        .fixedSize(horizontal: true, vertical: false)
                                }
                            }
                            .frame(height: 300)
                            .padding(.horizontal)
                        }
                    }
                }
                Spacer()
            }
            .onAppear(perform: {
                if viewModel.currentApod == nil {
                    viewModel.getApod()
                }
                if viewModel.roverPhotos == nil {
                    viewModel.getRoverPhotos()
                }
            })
            .navigationTitle(Text("NASA Open APIs"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
