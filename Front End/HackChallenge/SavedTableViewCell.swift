//
//  SavedTableViewCell.swift
//  HackChallenge
//
//  Created by Evan Azari on 5/4/19.
//  Copyright © 2019 Evan Azari. All rights reserved.
//

import UIKit

class SavedTableViewCell: UITableViewCell {


    var accountLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        accountLabel = UILabel()
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        accountLabel.text = "HEY"
        accountLabel.font = UIFont(name: "PingFangHK-Light", size: 20)
        contentView.addSubview(accountLabel)
        
        NSLayoutConstraint.activate([
            accountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(account: String){
        accountLabel.text = account
    }
}
