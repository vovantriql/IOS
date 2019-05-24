//
//  ContactCell.swift
//  iSpaceLab
//
//  Created by TRANVINHDAT on 5/2/19.
//  Copyright © 2019 Ho Dac Hung. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    var link: ViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let starButton = UIButton(type: .system)
        starButton.setImage( #imageLiteral(resourceName: <#T##String#>) , for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        starButton.tintColor = .red
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        
        accessoryView = starButton
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

