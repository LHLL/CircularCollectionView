//
//  ViewController.swift
//  CircularCollectionView
//
//  Created by 李玲 on 4/16/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circularCollectionView: UICollectionView!
    @IBOutlet weak var circularLayout: CircularLayout!
    
    fileprivate var data = ["Zero","First","Second","Third","Forth","Fifth","Sixth","Seventh","Eighth","Ninth","Tenth","One", "Two", "Three"]
    fileprivate var realData:[String] = []
    fileprivate var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circularCollectionView.register(UINib(nibName: "CircularCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CircularCell")
        circularCollectionView.delegate = CollectionFactory.shared
        circularCollectionView.dataSource = CollectionFactory.shared
        CollectionFactory.shared.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let vm = CollectionFactory.shared.registerViewModel(vm:CircularModel()) as! CircularModel
        circularLayout.delegate = vm
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
            if self.count < self.data.count {
                self.realData.append(self.data[self.count])
                self.count += 1
                DispatchQueue.main.async {
                    self.circularCollectionView.reloadData()
                }
            }else {
                self.count = 0
                timer.invalidate()
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController:FactoryDataSource {
  
    var dataContainer:[Any]{return realData}
}
