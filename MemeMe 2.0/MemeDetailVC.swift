//
//  MemeDetailVC.swift
//  MemeMe 2.0
//
//  Created by Nafisur Ahmed on 03/01/18.
//  Copyright © 2018 Nafisur Ahmed. All rights reserved.
//

import UIKit

class MemeDetailVC: UIViewController {

     var meme: Meme!
    @IBOutlet weak var memeImgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeImgView!.image = meme.memedImage
        //tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //tabBarController?.tabBar.isHidden = false
    }


}
