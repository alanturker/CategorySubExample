//
//  ViewController.swift
//  CategorySearchExample
//
//  Created by alanturker on 17.05.2022.
//

import UIKit

struct ParentCategory {
    var name: String
    var subCategories: [String]
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private weak var tableView: UITableView!
    
    private var isSub = false
    private var shouldWrite = false
    
    let categories = [
        ParentCategory(name: "Income", subCategories: ["Salary", "Bonus", "Rental Income"]),
        ParentCategory(name: "Housing", subCategories: ["Mortgage/Rent", "Property Tax", "Homeowner's Insurance"]),
        ParentCategory(name: "Türker", subCategories: ["rb", "natinaol"]),
        ParentCategory(name: "bora", subCategories: ["selena", "lb", "lucy"]),
        ParentCategory(name: "alim", subCategories: ["wr"]),
        ParentCategory(name: "Boşum ben", subCategories: [])
    ]
    
    var changingCategory: [ParentCategory] = []
    
    var subCategory: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(backButtonTapped))
        tableView.delegate = self
        tableView.dataSource = self
        changingCategory = categories
    }

    @objc func backButtonTapped() {
        changingCategory = categories
        isSub = false
        shouldWrite = false
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSub {
            return changingCategory.count
        } else {
            return subCategory.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if !isSub {
            cell.textLabel?.text = changingCategory[indexPath.row].name
        } else {
            cell.textLabel?.text = subCategory[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        for category in changingCategory {
            if category.name == changingCategory[indexPath.row].name, isSub == false {
                subCategory = changingCategory[indexPath.row].subCategories
                if !subCategory.isEmpty {
                    isSub = true
                } else {
                    print(changingCategory[indexPath.row].name)
                    shouldWrite = false
                    isSub = false
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        if isSub, shouldWrite {
            print(subCategory[indexPath.row])
        }
        
        isSub ? (shouldWrite = true) : (shouldWrite = false)
        
    }
    
}

