//
//  ViewController.swift
//  CollectionViewE2
//
//  Created by admin on 3/10/2559 BE.
//  Copyright © 2559 All2Sale. All rights reserved.
//

import UIKit
import Alamofire
import MapleBacon

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var mainCollectionView:UICollectionView!
    var mainDataArray = NSArray()
    
    
    func feedData() {
        let params = ["api":"productall","productall":"30"]
        Alamofire.request(.POST, "https://www.all2sale.com/sendmail/testfunction/json/apitest.php", parameters: params, encoding: .URL, headers: nil).responseJSON { (request, response, result) -> Void in
            self.mainDataArray = result.value as! NSArray
            //print(self.mainDataArray.description)
            self.mainCollectionView.reloadData()
        }   //print(result.value!)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 10
        print(self.mainDataArray.count)
        return self.mainDataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let col1 = collectionView.dequeueReusableCellWithReuseIdentifier("collectCell1", forIndexPath: indexPath) as? CustomCollectionViewCell
        
        //
        let item = self.mainDataArray[indexPath.row] as! NSDictionary
        let imageUrl = item.objectForKey("ProductShowImage") as? String
        var wwwURL = "https://www.all2sale.com/store/"
        wwwURL += imageUrl!
        let imageURL2 = NSURL(string: wwwURL)!
        //self.mActivityIndicarot.startAnimating()
        col1?.imageViewProduct.setImageWithURL(imageURL2)
        //col1?.imageViewProduct.setImageWithURL(imageURL2)
        col1?.lblName.text = item.objectForKey("ProductName") as? String
        col1?.lblProduct.text = item.objectForKey("StoreSid") as? String

        //
        return col1!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        feedData()
        
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

