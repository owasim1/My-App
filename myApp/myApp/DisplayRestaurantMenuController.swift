//
//  DisplayRestaurantMenuController.swift
//  myApp
//
//  Created by Omar Wasim on 7/21/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import Foundation

class DisplayRestaurantMenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var restuarantTitle: String?
    var menuCategorySection = [MenuCategory]()
    var menuCategoryItemsRow = [[MenuItem]]()
    var restaurant : Restaurant? {
        didSet {
                for category in (restaurant?.menuCategories)! {
                    menuCategorySection.append(category)
                }
            }
    }
    
    
    
    @IBOutlet weak var restaurantTitleLabel: UILabel!
    @IBOutlet weak var displayMenuTableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        if let title = restuarantTitle
        {
            restaurantTitleLabel.text = title
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuCategorySection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menuCategorySection[section].name
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var categoryName = [String]()
        for category in menuCategorySection{
            categoryName.append(category.name)
        }
        return categoryName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuCategorySection[section].items?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displayMenuItemCell") as! DisplayMenuItemCell
        
        let items = menuCategorySection[indexPath.section]
        let item = items.items?[indexPath.row]
            
        cell.itemNameLabel.text = item?.name
        cell.itemPriceLabel.text = String(describing: item!.price)
        
        return cell
    }
}
