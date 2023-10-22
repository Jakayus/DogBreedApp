//
//  HeroSectionView.swift
//  DogBreeds
//
//  Created by Joel Sereno on 10/21/23.
//

import SwiftUI

struct HeroSectionView: View {
    
    let heroMessage = "Can you recognize different dog breeds?"
    let heroSubMessage = "Search for breeds and see pictures to grow familiarity. Or simply tap the button below for a random dog image for extra cuteness!"
    var body: some View {
        VStack{
            Image(.hero)
                .resizable()
                .scaledToFill()
                .clipShape(.rect(cornerRadius: 10))
                .padding(.horizontal, 5)
                .padding(.vertical)
            Text(heroMessage)
                .font(.largeTitle)
                .padding(.bottom)
            Text(heroSubMessage)
                .font(.headline)
                .padding(.horizontal)
        }
    }
}

#Preview {
    HeroSectionView()
}
