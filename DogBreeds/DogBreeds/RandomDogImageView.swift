//
//  RandomDogImageView.swift
//  DogBreeds
//
//  Created by Joel Sereno on 10/21/23.
//

import SwiftUI

struct RandomDogImageView: View {
    let defaultDogURLString = "https://images.dog.ceo/breeds/segugio-italian/n02090722_002.jpg"
    
    @State private var dogImageURLString = ""
    @State private var firstStartUp = true
    
    var body: some View {
        VStack {
            // using Apple example of error handling for AsyncImage
            AsyncImage(url: URL(string: dogImageURLString )) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: 300, height: 250)
                        .cornerRadius(5)
                    
                } else if phase.error != nil {
                    Label("Could not load image", systemImage: "photo")
                        .foregroundColor(Color.primary)
                        .padding()
                } else {
                    if !firstStartUp {
                        ProgressView("Loading...")
                            .foregroundColor(Color.primary)
                    } else {
                        EmptyView()
                    }
                }
            }// end AsyncImage
            
            Button {
                grabRandomDogImageURL()
                firstStartUp = false
            } label: {
                Text("Next Dog 🐶")
                    .foregroundStyle(Color.primary)
                    .frame(maxWidth: 150)
            }
            .buttonStyle(.bordered)
            .foregroundColor(Color.black)
            .cornerRadius(5)
            .padding(.vertical)
        } // end VStack
    }
    
    func grabRandomDogImageURL() {
        
        // get JSON URL
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        // create URL request
        let urlRequest = URLRequest(url: url)
        
        // create URL Session task
        let task = URLSession.shared.dataTask(with: urlRequest) { data, reponse, error in
            
            if let data = data, let string = String(data: data, encoding: .utf8) {
                
                // convert string to Data format
                let DogData = Data(string.utf8)
                
                // create decoder and use it to decode based off of RandomDogImageItem
                let decoder = JSONDecoder()
                let dogImageURLItem = try! decoder.decode(RandomDogImageItem.self, from: DogData)
                
                //print(dogImageURLString.message)
                //dogImage = URL(string: dogImageURLString.message)
                dogImageURLString = dogImageURLItem.message
                
            } else {
                print("unsuccessful decoding - data not valid")
            }
        }
        task.resume()
    } // end function
    
}

#Preview {
    RandomDogImageView()
}
