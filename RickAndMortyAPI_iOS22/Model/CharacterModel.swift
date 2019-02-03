//
//  CharacterModel.swift
//  RickAndMortyAPI_iOS22
//
//  Created by Ivan Ramirez on 10/23/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

struct TopLevelObjet: Decodable {
    
    let results: [CharacterResult]
}

struct CharacterResult: Decodable {
    
    let name: String
    let status: String
    let id: Int
    let image: URL
    // Later version will get another property from the JSON
    //    let results: [Results]
    
    let origin: Origin
    //
    //    var originName: [String] {
    //        return results.map{$0.origin.name}
    //    }
}
//
//struct Results: Decodable {
//    let origin: Origin
//
//}
struct Origin: Decodable {
    let name: String
}




//{
//
//    let name: String
//    let status: String
//    let species: String
//    let orgin: Origin
//    let image = URL
//}
