//
//  DrinkTableViewController.swift
//  Drink
//
//  Created by Joshua Hoyle on 5/5/21.
//

import UIKit

class DrinkTableViewController: UITableViewController {
    
    //MARK: - Lifectycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDrinksForTableview()
    }
    //MARK: - Properties
    var drinks: [Drink] = []
    //MARK: - Function
    func fetchDrinksForTableview() {
        DrinkController.fetchDrink { (result) in
            
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let drinks):
                    self.drinks = drinks
                    self.tableView.reloadData()
                    print(drinks)
                    
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath) as? DrinkTableViewCell
        
        let drink = drinks[indexPath.row]
        
        cell?.drink = drink
        
       
        
        return cell ?? UITableViewCell()
    }
    
    
}//End of Class
