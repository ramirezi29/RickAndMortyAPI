//
//  CharacterTaViewController.swift
//  RickAndMortyAPI_iOS22
//
//  Created by Ivan Ramirez on 10/23/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit
import AVFoundation

class CharacterViewController: UIViewController  {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var headerLogoImageView: UIImageView!
    @IBOutlet weak var characterSearchBar: UISearchBar!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    var characterResults: [CharacterResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Search bar
        characterSearchBar.delegate = self
        characterSearchBar.placeholder = "Enter 'Dead' or 'Alive'" 
        
        // Activity Indicator
        activityIndicator.isHidden = true
        
        // CollectionView
        collectionViewOutlet.dataSource = self
        collectionViewOutlet.delegate = self
    }
}

extension CharacterViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharactersDetailCollectionViewCell else {return UICollectionViewCell()}
        
        let character = characterResults[indexPath.row]
        cell.charctersResults = character
        
        // NOTE: -  Make the call for the image
        
        CharacterController.fetchCharacterImage(with: character) { (characterImage, error) in
            if let characterImage = characterImage {
                cell.characterImage = characterImage
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.backgroundColor = UIColor(white: 0, alpha: 0)
    }
}

extension CharacterViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text?.lowercased(), !searchText.isEmpty
            else {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                return
        }
        
        activityIndicator.color = UIColor(red: 0.3, green: 165/255, blue: 0.09, alpha: 1)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        characterSearchBar.resignFirstResponder()
        
        CharacterController.fetchCharacter(with: searchText) { (characterResults, error) in
            guard let characterResults = characterResults else {return}
            
            self.characterResults = characterResults
            
            for character in characterResults {
                print(character.name)
            }
            
            DispatchQueue.main.async {
                self.characterSearchBar.text = ""
                self.collectionViewOutlet.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }
}
