//
//  CharacterController.swift
//  RickAndMortyAPI_iOS22
//
//  Created by Ivan Ramirez on 10/23/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class CharacterController {
    
    static let baseURL = URL(string: "https://rickandmortyapi.com")
    
    // private init() {}
    
    typealias fetchCharacterCompletion =  ([CharacterResult]?, NetworkingError?) -> Void
    
    typealias FetchImageCompletion = ((UIImage?), NetworkingError?) -> Void
    
    // MARK: - Fetch Caracter Function
    
    static func fetchCharacter(with searchText: String, completion: @escaping fetchCharacterCompletion) {
        
        guard let unwrappedUrl = baseURL else {completion(nil, .badBaseURL("\n\nFix base URL\n\n"))
            fatalError("\n\nBad Base URL Do Not Continue\n\n")
        }
        
        let url = unwrappedUrl.appendingPathComponent(NetworkKeys.apiComponent.rawValue).appendingPathComponent(NetworkKeys.characterComponent.rawValue)
        
        // TEST: Print
        print(url.absoluteString)
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let aliveStatusEntrySearchQuery = URLQueryItem(name: NetworkKeys.statusComponent.rawValue, value: searchText)
        
        components?.queryItems = [aliveStatusEntrySearchQuery]
        
        // TEST: Print
        print(components?.url?.absoluteString ?? "\n\n There's an issue with the URL,  it could be nil or empty\n\n")
        
        guard let builtURL = components?.url else { completion(nil, .badBuiltURL("\n\nThere's an issue with the built url\n\n"))
            return
        }
        
        URLSession.shared.dataTask(with: builtURL) { (data, _, error) in
            if let error = error {
                print("\n\n🚀 There was an error with dataTask in: \n\n \(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil, .forwardedError(error)); return
            }
            guard let data = data else {
                completion(nil, .invalidData("\n\nInvalid data\n\n")); return
            }
            
            // NOTE: - Time to get our Decoding on
            do {
                // CHECK: Not sure if TopLevelObject is an array
                let topLevelObjet = try JSONDecoder().decode(TopLevelObjet.self, from: data)
                let charactersThatCameBackFromTheWeb = topLevelObjet.results
                completion(charactersThatCameBackFromTheWeb, nil)
                
            } catch let error {
                print("\n\n🚀 There was an error with decoding the data in: \n\n \(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil, .forwardedError(error));return
            }
            }.resume()
    }
    
    // MARK: - Fetch Images
    static func fetchCharacterImage(with characterResults: CharacterResult, completion: @escaping FetchImageCompletion) {
        
        // MARK: - URL Session
        URLSession.shared.dataTask(with: characterResults.image) { (data, _, error) in
            if let error = error {
                print("\n\n🚀 There was an error with dataTask fetching an image in: \n\n \(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil, .forwardedError(error)); return
            }
            
            // NOTE: - Data that came back from the web/json
            guard let data = data else {
                completion(nil, .invalidData("\n\nInvalid Data\n\n")); return
            }
            
            let image = UIImage(data: data)
            completion(image, nil)
            
            }.resume()
    }
} 


//End goal URL
//https://rickandmortyapi.com/api/character/
