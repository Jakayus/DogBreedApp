//
//  HomeScreenView.swift
//  DogBreeds
//
//  Created by Joel Sereno on 10/21/23.
//

import SwiftUI

struct HomeScreenView: View {

    var body: some View {
        ScrollView {
            Image(.header)
                .padding(.top, 30)
            Spacer()
            HeroSectionView()
            RandomDogImageView()
            Spacer()
        } // end ScrollView
        
    } // end View
    

}

#Preview {
    HomeScreenView()
}






