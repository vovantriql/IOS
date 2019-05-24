//
//  ViewController.swift
//  iSpaceLab
//
//  Created by Ho Dac Hung on 4/24/19.
//  Copyright © 2019 Tran Vinh Dat. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UITableViewController {
    let cellID="cellID"
    var names = [
        ExpandableNames(isExpanded: true, names: ["Đạt","Đình"]),
        ExpandableNames(isExpanded: true, names: ["Thầy","Trụ"]),
        ExpandableNames(isExpanded: true, names: ["Hưng","Hùng"]),
        ExpandableNames(isExpanded: true, names: ["An","Anh"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        fetchContacts()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style:.plain, target: self, action:#selector(handleReload))
        navigationItem.title="Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    var isLeft = true
    @objc func handleReload() {
        var indexPathToReload = [IndexPath]()
        for section in names.indices{
            for row in names[section].names.indices{
                let indexPath = IndexPath (row: row, section: section)
                indexPathToReload.append(indexPath)
            }
        }
        isLeft = !isLeft
        let animationStyle = isLeft ? UITableView.RowAnimation.left : .right
        tableView.reloadRows(at: indexPathToReload, with: animationStyle)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ContactCell(style: .subtitle, reuseIdentifier: cellID)
        
        cell.link = self
        
        let favoritableContact = names[indexPath.section].names[indexPath.row]
        
        cell.textLabel?.text = favoritableContact.contact.givenName + " " +
            favoritableContact.contact.familyName
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        cell.detailTextLabel?.text =
            favoritableContact.contact.phoneNumbers.first?.value.stringValue
        
        cell.accessoryView?.tintColor = favoritableContact.hasFavorited ? UIColor.red :
            .lightGray
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
//        cell.textLabel?.text = names[indexPath.section].names[indexPath.row]
        return cell
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return names.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.tag = section
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        return button
            }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    @objc func handleExpandClose(button:UIButton){
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in names[section].names.indices{
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = names[section].isExpanded
        names[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open" : "Close", for:.normal)
        
        if(isExpanded){
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    @objc private func handleMarkAsFavorite(){

    }

    func someMethodIWantToCall(cell : UITableViewCell) {
        guard let indexPathTapped = tableView.indexPath(for: cell) else {return}

        let contact = names[indexPathTapped.section].names[indexPathTapped.row]
        print(contact)
        
        let hasFavorited = contact.hasFavorited
        
        names[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited


        //tableView.reloadRows(at: [indexPathTapped], with: .fade)
        
        cell.accessoryType?.tintColor = hasFavorited ? UIColor.lightGray: .red

    }
    
    private func fetchContacts(){
        print("Attempting to fetch contacts today...")
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts, completionHandler: { (granted, err) in
            if let err = err {
                print("Falied to request access:", err)
                return
            }
            if granted {
                print("Access granted ")
                
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: key as [CNKeyDescriptor])
                do {
                    var favoritableContacts = [FavoritableContact]()
                    
                    try store.enumerateContacts(with: request, usingBlock: (contact, StopPointerIfYouWantToStopEnumerating), in
                        
                        print(contact.givenName)
                        print(contact.familyName)
                        print(contact.phoneNumbers.first?.value.stringValue ?? "")
                        
                        favoritalbeContacts.append(FavoritableContacts(contact: contact,
                        hasFavorited: false))
                        
                    )}
                
                    let names = ExpandableNames(isExpanded: true, names:
                        favoritableContacts)
                    self.twoDimensionalArray = [names]
            }; catch var err: String {
                print("Failed to enumerrate contacts:", err)
            }
        })
    
    }
}

