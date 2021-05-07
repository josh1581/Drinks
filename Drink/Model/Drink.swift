//
//  Drink.swift
//  Drink
//
//  Created by Joshua Hoyle on 5/5/21.
//

import Foundation

struct TopLevelObject: Decodable {
    let drinks: [Drink]

}

struct Drink: Decodable {
    let strDrink: String
    let strDrinkThumb: String
    }//end of struct
