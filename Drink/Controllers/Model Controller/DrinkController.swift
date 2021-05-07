//
//  DrinkController.swift
//  Drink
//
//  Created by Joshua Hoyle on 5/5/21.
//

import UIKit

class DrinkController {
    static let baseURL = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/")
    
static let searchEndpoint = "search.php"
    
    
    static func fetchDrink(completion: @escaping (Result<[Drink], DrinkError>) -> Void)  {
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let searchURL = baseURL.appendingPathComponent(searchEndpoint)
    
        
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        let drinkQuery = URLQueryItem(name: "f", value: "a")
        components?.queryItems = [drinkQuery]
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
            print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("POSTS STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let arrayOfDrinks = topLevelObject.drinks
                print(arrayOfDrinks)
                completion(.success(arrayOfDrinks))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        
            
        }.resume()
        
    }
    
    static func fetchThumbnail(drink: Drink, completion: @escaping (Result<UIImage, DrinkError>) -> Void) {
        
        guard let thumbnailURL = URL(string: drink.strDrinkThumb) else {return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: thumbnailURL) {data, response, error in
            
            if let error = error {
                return
                    completion(.failure(.thrownError(error)))
            }
//Step 4: Handle Response
            if let response = response as? HTTPURLResponse {
                print("Thumbnail Status Code: \(response.statusCode)")
            }
                        //Step 5: Guard data to make sure it exists
            guard let data = data else {return completion(.failure(.noData))}
            
            //Step 6: Decode
            guard let thumbnail = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            completion(.success(thumbnail))
        }.resume()
       
        
    }
}//End of Class

