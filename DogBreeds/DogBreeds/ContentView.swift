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
        
        TabView(selection: $tabSelection){
            HomeScreenView()
                .tabItem { Label("Home", systemImage: "house") }
                .tag(Tab.Home)
            DogBreedsView()
                .tabItem { Label("Dog Breeds", systemImage: "dog") }
                .tag(Tab.DogBreeds)
        }
    }
}

#Preview {
    ContentView()
}


struct HomeScreenView: View {
    
    @State private var dogImageURLString = ""
    let defaultDogURLString = "https://images.dog.ceo/breeds/segugio-italian/n02090722_002.jpg"
    
    let heroMessage = "Can you recognize different dog breeds?"
    let heroSubMessage = "Search for breeds and see pictures for familiarity. Or simply tap the button below for a random dog image!"
    
    
    var body: some View {
        ScrollView {
            Image(.header)
                .padding(.top, 30)
            Spacer()
            Image(.hero)
                .resizable()
                .scaledToFill()
                .clipShape(.rect(cornerRadius: 10))
                .padding(.horizontal, 5)
                .padding(.vertical)
            VStack{
                Text(heroMessage)
                    .font(.largeTitle)
                    .padding(.bottom)
                Text(heroSubMessage)
                    .font(.headline)
                    .padding(.horizontal)
            }
            // using Apple example of error handling for AsyncImage
            VStack {
                AsyncImage(url: URL(string: dogImageURLString )) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .frame(width: 300, height: 250)
                            .cornerRadius(5)
                        
                    } else if phase.error != nil {
                        Label("Could not load image", systemImage: "photo")
                            .foregroundColor(Color(.primary1))
                    } else {
                        ProgressView("Loading...")
                            .foregroundColor(Color.white)
                            .tint(Color.white)
                        
                    }
                }// end AsyncImage
                
                Button {
                    grabRandomDogImageURL()
                } label: {
                    Text("Next Dog 🐶")
                        .frame(maxWidth: 150)
                }
                .buttonStyle(.bordered)
                .foregroundColor(Color.black)
                .cornerRadius(5)
                .padding(.vertical)
            } // end VStack
            

            Spacer()
        }
    } // end View
        
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
