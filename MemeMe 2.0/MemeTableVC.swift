//
//  MemeTableVC.swift
//  MemeMe 2.0
//
//  Created by Nafisur Ahmed on 28/12/17.
//  Copyright © 2017 Nafisur Ahmed. All rights reserved.
//

import UIKit

class MemeTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var memeTable: UITableView!
    var memes = [Meme]()
    override func viewDidLoad() {
        super.viewDidLoad()

        memeTable.delegate = self
        memeTable.dataSource = self
        memeTable.tableFooterView = UIView()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        memeTable.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memeTable.dequeueReusableCell(withIdentifier: "cell")!
        
        if let memedImg = memes[indexPath.row].memedImage
        {
            let cellText = memes[indexPath.row].top! + " " + memes[indexPath.row].bottom!
            cell.imageView?.image = memedImg
            cell.textLabel?.text = cellText
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier:
            "memeDetailVC") as! MemeDetailVC
        detailController.meme = memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }

}




