//
//  ViewController.swift
//  iSpaceLab
//
//  Created by Ho Dac Hung on 4/24/19.
//  Copyright © 2019 Tran Vinh Dat. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let cellID="cellID"
    let names = [
        ["Đạt","Đình"],
        ["Thầy","Trụ"],
        ["Hưng","Hùng"],
        ["An","Anh"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style:.plain, target: self, action:#selector(handleReload))
        navigationItem.title="Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    var isLeft = true
    @objc func handleReload() {
        var indexPathToReload = [IndexPath]()
        for section in names.indices{
            for row in names[section].indices{
                let indexPath = IndexPath (row: row, section: section)
                indexPathToReload.append(indexPath)
            }
        }
        isLeft = !isLeft
        let animationStyle = isLeft ? UITableView.RowAnimation.left : .right
        tableView.reloadRows(at: indexPathToReload, with: animationStyle)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = names[indexPath.section][indexPath.row]
        return cell
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return names.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text=names[section][0].prefix(1)+"";
        label.backgroundColor=UIColor.lightGray;
        return label;
    }
}

