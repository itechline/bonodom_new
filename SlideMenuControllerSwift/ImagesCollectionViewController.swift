//
//  ImagesCollectionViewController.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 21..
//  Copyright © 2016. Itechline. All rights reserved.
//

import UIKit

class ImagesCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var imagesToUpload: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.reloadData()
    }
}

extension ImagesCollectionViewController : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (!imagesToUpload.isEmpty) {
            print ("NOT EMPTY")
            return imagesToUpload.count
        }
        print ("EMPTY")
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print ("MAKING CELL 1")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("image_cell", forIndexPath: indexPath) as! ImageCell
        print ("MAKING CELL 2")
        cell.imageView.image = imagesToUpload[indexPath.row]
        print ("MAKING CELL 3")
        return cell
    }
    
}

extension ImagesCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    /*func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }*/
    
}
