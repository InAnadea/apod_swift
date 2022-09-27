//
//  ContentView.swift
//  Nasa APOD
//
//  Created by Ivan Nazarov on 15.09.2022.
//

import SwiftUI

struct APODView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                if let apod = viewModel.currentApod {
                    APODMediaView(apod: apod)
                }
                if let text = viewModel.currentApod?.title {
                    Text(text)
                        .font(.largeTitle)
                        .padding()
                }
                if let text = viewModel.currentApod?.explanation {
                    Text(text).padding()
                }
            }
        }
        .onAppear(perform: { viewModel.getApod() })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        APODView()
    }
}
