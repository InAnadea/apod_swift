//
//  ContentView.swift
//  Nasa APOD
//
//  Created by Ivan Nazarov on 15.09.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var apodViewModel = APODViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                if let uri = apodViewModel.currentApod?.hdurl {
                    AsyncImage(url: URL(string: uri)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                            
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                            
                        case .failure:
                            Image(systemName: "photo")
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                if let text = apodViewModel.currentApod?.title {
                    Text(text)
                        .font(.largeTitle)
                        .padding()
                }
                if let text = apodViewModel.currentApod?.explanation {
                    Text(text).padding()
                }
            }
            
        }
        .onAppear(perform: { apodViewModel.getApod() })
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
