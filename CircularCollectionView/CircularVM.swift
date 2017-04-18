//
//  CircularVM.swift
//  CircularCollectionView
//
//  Created by 李玲 on 4/16/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class CircularModel:Tags {
    
    var viewSize:CGSize{return CGSize(width:100,height:100)}
    var identifier:String{return "CircularCell"}
    var type:Any{return "First Cell"}
    fileprivate var uiData:String!
    
    func updateData(_ data:Any) {
        guard data is String else {return}
        uiData = data as! String
    }
}

extension CircularModel:CircularCellProtocol {
    var title:String {return uiData}
}

extension CircularModel:CircularDelegateLayout {
    func collectionView(collectionView:UICollectionView, radiusForItemAtIndexPath indexPath:IndexPath) -> CGFloat {
        return viewSize.width
    }
}
