//
//  RoverPhotoView.swift
//  NASA
//
//  Created by Ivan Nazarov on 27.09.2022.
//

import SwiftUI

struct RoverPhotoView: View {
    var photo: RoverPhotos.Photo
    var body: some View {
        AsyncImage(url: URL(string: photo.img_src)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            case .failure:
                Image(systemName: "photo")
                
            @unknown default:
                EmptyView()
            }
        }
        .overlay(alignment: .bottomTrailing) {
            VStack(alignment: .trailing) {
                HStack(alignment: .bottom) {
                    Text(photo.rover.name)
                    Text(photo.camera.full_name)
                        .font(.caption)
                }
                Text("SOL: \(String(photo.sol))")
                    .font(.caption2)
            }
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 15))
        }
        .cornerRadius(6)
    }
}

struct RoverPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        RoverPhotoView(photo: RoverPhotos.Photo(id: UUID(), sol: 1010, img_src: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F34%2F2018%2F05%2F12170411%2Fcat-kitten-138468381.jpg&q=60", earth_date: "data", rover: RoverPhotos.Photo.Rover(id: 10, name: "Cool rover", landing_date: "27-12-1999", launch_date: "9-1-1999", status: "cool status"), camera: RoverPhotos.Photo.Camera(id: 10, name: "ASDF", rover_id: 10, full_name: "Cool ASDF camera")))
            .fixedSize(horizontal: false, vertical: true)
    }
}
