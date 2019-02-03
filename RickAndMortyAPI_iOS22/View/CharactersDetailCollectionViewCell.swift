//
//  CharactersDetailCollectionViewCell.swift
//  RickAndMortyAPI_iOS22
//
//  Created by Ivan Ramirez on 10/24/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class CharactersDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var charctersResults: CharacterResult? {
        didSet {
            updateViews(characterResult: charctersResults)
        }
    }
    
    var characterImage: UIImage? {
        didSet{
            updateViews(characterImage: characterImage)
        }
    }
    
    func updateViews(characterResult: CharacterResult? = nil, characterImage: UIImage? = nil ) {
        DispatchQueue.main.async {
            if let characterResult = characterResult {
                
                self.originLabel.text = characterResult.origin.name
                self.IDLabel.text = "\(characterResult.id)"
                self.statusLabel.text = characterResult.status
                self.nameLabel.text = characterResult.name
                
            } else if let characterImage = characterImage {
                self.characterImageView.image = characterImage
            }
        }
    }
}



