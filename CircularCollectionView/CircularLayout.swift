//
//  CircularLayout.swift
//  CircularCollectionView
//
//  Created by 李玲 on 4/16/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

protocol CircularDelegateLayout {
    func collectionView(collectionView:UICollectionView, radiusForItemAtIndexPath indexPath:IndexPath) -> CGFloat
}

class CircularLayout: UICollectionViewLayout {
    //Well, I am not using delegate since I am control freak, however, you can customize radius if you want through protocol above.
    var delegate:CircularDelegateLayout!
    fileprivate var viewCenter:CGPoint!
    fileprivate var numberOfItems = 0
    fileprivate var centerCircleRadius:CGFloat!
    fileprivate var itemRadius:CGFloat!
    fileprivate var itemSize:CGSize!
    fileprivate var centerItemSize:CGSize!
    
    override var collectionViewContentSize: CGSize {
        return collectionView!.bounds.size
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else {return}
        //You only have one section, yes, only one
        numberOfItems = collectionView.numberOfItems(inSection: 0)
        viewCenter = CGPoint(x: collectionView.bounds.midX, y: collectionView.bounds.midY)
        let shortest = min(collectionView.bounds.width, collectionView.bounds.height)
        centerCircleRadius = shortest / 3.4
        
        //Why 7 is the magic number? Well, to be frankly, it's not, but I like 7, so I put it here.
        if numberOfItems > 7 {
            /*switch reader {
                case .EastAsian:
                    print("Ask your high school teacher to figure out why.")
                default:
                    print("Never mind, it's Voodoo, just use it.")
             }
             */
            itemRadius = CGFloat(2 * Double(centerCircleRadius) * sin(.pi / Double(numberOfItems - 1)))
        }else {
            itemRadius = centerCircleRadius
        }
        
        itemSize = CGSize(width: itemRadius, height: itemRadius)
        centerItemSize = CGSize(width: centerCircleRadius, height: centerCircleRadius)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let angle = 2 * .pi * CGFloat(indexPath.item) / CGFloat(numberOfItems - 1)
        
        switch indexPath.item {
        case 0:
            attributes.center = viewCenter
            attributes.size = centerItemSize
        default:
            /*switch reader {
             case .EastAsian:
                print("Ask your high school teacher to figure out why.")
             default:
                print("Never mind, it's Voodoo, just use it.")
             }
             */
            attributes.center = CGPoint(x: viewCenter.x + centerCircleRadius * cos(angle), y: viewCenter.y + centerCircleRadius * sin(angle))
            attributes.size = itemSize
        }
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else {return nil}
        return (0..<collectionView.numberOfItems(inSection: 0)).flatMap{ item -> UICollectionViewLayoutAttributes? in
            self.layoutAttributesForItem(at: IndexPath(item: item, section: 0))
        }
    }
    
}
