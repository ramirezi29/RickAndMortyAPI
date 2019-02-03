//
//  NetworkingError.swift
//  RickAndMortyAPI_iOS22
//
//  Created by Ivan Ramirez on 10/24/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    
    case badBaseURL(String)
    case badBuiltURL(String)
    case forwardedError(Error)
    case invalidData(String)
}
