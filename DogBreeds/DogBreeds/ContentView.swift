//
//  ContentView.swift
//  DogBreeds
//
//  Created by Joel Sereno on 10/21/23.
//

import SwiftUI


struct ContentView: View {
    
    enum Tab {
        case Home, DogBreeds, RandomDog
    }
    
    @State private var tabSelection = Tab.Home

    
    var body: some View {
        ZStack {
            Color.blue
            TabView(selection: $tabSelection){
                HomeScreenView()
                    .tabItem { Label("Home", systemImage: "house") }
                    .tag(Tab.Home)
                DogBreedsView()
                    .tabItem { Label("Dog Breeds", systemImage: "dog") }
                    .tag(Tab.DogBreeds)
                //                RandomDogView()
                //                    .tabItem { Label("Random Dog", systemImage: "photo")}
                //                    .tag(Tab.RandomDog)
            }
        }
    }
}

#Preview {
    ContentView()
}


struct HomeScreenView: View {
    
    @State private var dogImageURLString = ""
    
    var body: some View {
        VStack {
            Image(.header)
                .padding(.top)
            Spacer()
            // using Apple example of error handling for AsyncImage
            AsyncImage(url: URL(string: dogImageURLString ?? "no image")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(5)
                        .padding()
                    
                } else if phase.error != nil {
                    Label("Could not load image", systemImage: "photo")
                        .foregroundColor(Color("Secondary1"))
                } else {
                    ProgressView("Loading...")
                        .foregroundColor(Color.white)
                        .tint(Color.white)
                    
                }
            } // end AsyncImage
            Button("Demo") {
                grabRandomDogImageURL()
            }
            Image(.hero)
                .resizable()
                .scaledToFit()
            VStack(spacing: 20){
                Text("Can you recognize differnet dog breeds?")
                    .font(.largeTitle)
                    .padding()
                Text("")
                    .font(.headline)
                    .padding()
            }
            Spacer()
        }
    } // end View
        
        func grabRandomDogImageURL() -> String {
            
            var dogImage = ""
            // get JSON URL
            let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
            
            // create URL request
            let urlRequest = URLRequest(url: url)
            
            // create URL Session task
            let task = URLSession.shared.dataTask(with: urlRequest) { data, reponse, error in
                
                if let data = data, let string = String(data: data, encoding: .utf8) {
                    
                    // convert string to Data format
                    let DogData = Data(string.utf8)
                    
                    // create decoder and use it to decode based off of MenuList created earlier
                    let decoder = JSONDecoder()
                    let dogImageURLItem = try! decoder.decode(RandomDogImageItem.self, from: DogData)
                    
                    //print(dogImageURLString.message)
                    //dogImage = URL(string: dogImageURLString.message)
                    dogImageURLString = dogImageURLItem.message
                    print(dogImage)
                    
                } else {
                    print("unsuccessful decoding - data not valid")
                }
            }
            task.resume()
            
            return dogImage
        } // end function
        
    }
    
    struct DogBreedsView: View {
        var body: some View {
            Text("Coming Soon!")
        }
    }
    
    struct RandomDogView: View {
        var body: some View {
            Text("Coming Soon!")
        }
    }
    
    
    // must decode dog string first
    struct RandomDogImageItem: Decodable {
        let message: String
        let status: String
    }
