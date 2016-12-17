//
//  TableViewController.swift
//  GitTopProjects
//
//  Created by bill on 12/15/16.
//  Copyright © 2016 bill. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var repository: [String: AnyObject]!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var cloneURLLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let name =  repository["full_name"] as? String else {
            print("ERROR: full_name data not found")
            return
        }
        
        nameLabel.text = name
        
        guard let description = repository["description"] as? String else {
            print("WARN: description data not found")
            descriptLabel.text = "N/A"
            return
        }
        
        descriptLabel.text = description
        
        let owner = repository["owner"] as! [String: AnyObject]
        
        guard let login = owner["login"] as? String else {
            print("ERROR: login name not found")
            return
        }
        
        ownerLabel.text = login
        
        guard let size = repository["size"] as? Int else{
            print("WARN: size not found")
            sizeLabel.text = "N/A"
            return
        }
        
        sizeLabel.text = String(size)
        
        guard let forks = repository["forks"] as? Int else {
            print("WARN: forks number not found")
            forksLabel.text = "N/A"
            return
        }
        
        forksLabel.text = String(forks)
        
        
        guard let cloneURL = repository["clone_url"] as? String else{
            print("WARN: clone url not found")
            cloneURLLabel.text = "N/A"
            return
        }
        
        cloneURLLabel.text = cloneURL
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
