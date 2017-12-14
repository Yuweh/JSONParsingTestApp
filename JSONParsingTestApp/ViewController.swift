//
//  ViewController.swift
//  JSONParsingTestApp
//
//  Created by Francis Jemuel Bergonia on 14/12/2017.
//  Copyright © 2017 Francis Jemuel Bergonia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    //MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableData:[[String: AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // 1. Read JSON from bundle and convert it to data
        let url = Bundle.main.url(forResource: "CelestialBeing", withExtension: "json")
        
        if let url = url{
            let data = NSData(contentsOf: url)
            
            // 2. serialize JSON from Data
            if let data = data {
                // 1. print(data)
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
                   
                    // 2. print(jsonObject)
                    
                    // 3. get or read data from Dictionary from jsonObject
                    if let object = jsonObject as? [String: AnyObject] {
                        if let allPersonnel = object["CelestialBeing"] as? [[String:AnyObject]] {
                            
                            // 3. print(allPersonnel)
                            tableData = allPersonnel
                            tableView.reloadData()
                        }
                    }
                    
                } catch {
                    print("error")
                }
            }
        }
    }
    
    // 4. Displaying JSOn content on tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jsonCell", for: indexPath)
        
        // 4. setting JSON data on the tableview cell
        
        let CelestialBein = tableData[indexPath.row]
        let name = CelestialBein["fullName"] as? String
        let ms = CelestialBein["ms"] as? String
        
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = ms
        
        return cell
    }
}

