//
//  MemeCollectionVC.swift
//  MemeMe 2.0
//
//  Created by Nafisur Ahmed on 28/12/17.
//  Copyright © 2017 Nafisur Ahmed. All rights reserved.
//

import UIKit

class MemeCollectionVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

     var memes = [Meme]()
    @IBOutlet weak var memeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        memeCollectionView.delegate = self
        memeCollectionView.dataSource = self

      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        memeCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.imgView.image = memes[indexPath.row].memedImage
        return cell
    }
}
