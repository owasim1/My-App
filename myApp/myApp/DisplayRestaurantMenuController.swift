//
//  DisplayRestaurantMenuController.swift
//  myApp
//
//  Created by Omar Wasim on 7/21/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import Foundation

class DisplayRestaurantMenuController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var restuarantTitle: String?
    var menuCategorySection = [MenuCategory]()
    var menuCategoryItemsRow = [[MenuItem]]()
    var itemSearched: String! = ""
    var restaurant : Restaurant? {
        didSet {
                for category in (restaurant?.menuCategories)! {
                    menuCategorySection.append(category)
                }
            }
    }
    
    @IBAction func unwindToMenuController(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindFromMap(segue:UIStoryboardSegue) {
    }
    
    @IBAction func mapTapped(_ sender: Any) {
        performSegue(withIdentifier: "toMapView", sender: nil)
    }
    
    @IBAction func showButton(_ sender: Any) {
        performSegue(withIdentifier: "toMapView", sender: self)
    }

    
    @IBOutlet weak var restaurantTitleLabel: UILabel!
    @IBOutlet weak var displayMenuTableView: UITableView!
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapView"{
            let destinationController = segue.destination as! MapViewController
            destinationController.markerName = (restaurant?.name)!
            destinationController.resultsOnMap = [restaurant!]
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        displayMenuTableView.tableFooterView = UIView(frame: .zero)
        displayMenuTableView.separatorColor = UIColor(red: 190.0/255.0, green: 30.0/255.0, blue: 45.0/255.0, alpha: 1.0)
        
        if let title = restuarantTitle
        {
            self.navigationItem.title = title
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuCategorySection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menuCategorySection[section].name
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        let headerView = UIView()
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Roboto-Medium", size: 14)
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.textAlignment = NSTextAlignment.center
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let shadowView = UIView()
//        
//        let gradient = CAGradientLayer()
//        gradient.frame.size = CGSize(width: tableView.bounds.width, height: 15)
//        let stopColor = UIColor.gray.cgColor
//        
//        let startColor = UIColor.white.cgColor
//        
//        
//        gradient.colors = [stopColor,startColor]
//        
//        
//        gradient.locations = [0.0,0.8]
//        
//        shadowView.layer.addSublayer(gradient)
//        
//        
//        return shadowView
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuCategorySection[section].items?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displayMenuItemCell") as! DisplayMenuItemCell
        
        let items = menuCategorySection[indexPath.section]
        let item = items.items?[indexPath.row]
            
        cell.itemNameLabel.text = item?.name
        cell.itemPriceLabel.text = "$ " + String(format: "%.2f", item!.price)
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }

}
extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
