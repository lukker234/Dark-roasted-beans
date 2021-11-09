//
//  CoffeeTableViewCell.swift
//  Dark roasted beans
//
//  Created by Luc Daalmeijer on 06/11/2021.
//

import UIKit

class CoffeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var coffeeLabel: UILabel!
    @IBOutlet weak var checkbox: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 15, bottom: 3, right: 15))
        contentView.layer.cornerRadius = 5.0
    }
}
