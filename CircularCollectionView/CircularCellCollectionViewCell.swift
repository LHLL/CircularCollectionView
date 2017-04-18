//
//  CircularCellCollectionViewCell.swift
//  CircularCollectionView
//
//  Created by 李玲 on 4/16/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

protocol CircularCellProtocol {
    var title:String{get}
}

class CircularCellCollectionViewCell: WFCollectionCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width/2
    }
    
    override func configureCell<T>(t: T) {
        if t is CircularModel {
            titleLabel.text = (t as! CircularModel).title
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
    }
}
