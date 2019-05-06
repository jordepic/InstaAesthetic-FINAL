//
//  ColorCollectionViewCell.swift
//  HackChallenge
//
//  Created by Evan Azari on 4/24/19.
//  Copyright © 2019 Evan Azari. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {

    var circle: UIView!
    let size: CGFloat = 70
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = size/2
        circle.clipsToBounds = true
        contentView.addSubview(circle)
        
        NSLayoutConstraint.activate([
            circle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            circle.heightAnchor.constraint(equalToConstant: 70),
            circle.widthAnchor.constraint(equalToConstant: 70)
            ])
    }
    
    func configure(for RBG: [CGFloat], isNil: Bool){
        if !isNil{
            let color = UIColor(red: RBG[0]/255.0, green: RBG[1]/255.0, blue: RBG[2]/255.0, alpha: 1)
            circle.backgroundColor = color
            circle.layer.borderWidth = 1
            circle.layer.borderColor = UIColor.black.cgColor
        }
        else{
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
