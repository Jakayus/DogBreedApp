//
//  DogData.swift
//  DogBreeds
//
//  Created by Joel Sereno on 10/21/23.
//

import Foundation

// Needed to decode random dog image
struct RandomDogImageItem: Decodable {
    let message: String
    let status: String
}
