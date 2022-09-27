//
//  APODMediaView.swift
//  NASA
//
//  Created by Ivan Nazarov on 27.09.2022.
//

import SwiftUI
import AVKit

struct APODMediaView: View {
    let apod: APOD
    var body: some View {
        switch apod.mediaType {
        case "video":
            VideoPlayer(player: AVPlayer(url:  URL(string: apod.url!)!))
            
        case "image":
            if let url = apod.hdurl ?? apod.url {
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
            
        default:
            if let url = apod.url {
                Link("Link", destination: URL(string: url)!)
            } else {
                Text("Unknown media type")
            }
        }
    }
}

struct APODMediaView_Previews: PreviewProvider {
    static var previews: some View {
        APODMediaView(apod: APOD())
    }
}
