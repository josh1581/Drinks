//
//  DrinkTableViewCell.swift
//  Drink
//
//  Created by Joshua Hoyle on 5/5/21.
//

import UIKit

class DrinkTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    
    //MARK: - Properties
    var drink: Drink? {
        didSet {
            updateViews()
        }
    }
    //MARK: - Functions
    func updateViews() {
        
        guard let drink = drink else {return}
        
        drinkName.text = drink.strDrink
                        
        DrinkController.fetchThumbnail(drink: drink) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let thumbnail ):
                    self.drinkImage.image = thumbnail
                case .failure(let error):
                    self.drinkImage.image = UIImage(named: "nobooze")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")                }
            }
        }
        
    }
    
}//End of Class

