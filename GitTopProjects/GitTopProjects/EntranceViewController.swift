//
//  ViewController.swift
//  GitTopProjects
//
//  Created by bill on 12/15/16.
//  Copyright © 2016 bill. All rights reserved.
//

import UIKit

class EntranceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var colleactionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var appDelegate: AppDelegate!
    
    var repositories: [[String: AnyObject]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate!
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.colleactionView.dataSource = self
        self.colleactionView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        
    }

    func getData(){
        
        
        
        let methodParameters = [
            Constants.GitAPIParameterKeys.SearchQuery: Constants.GitAPIParameterValues.Language + appDelegate.defualtLanguage,
            Constants.GitAPIParameterKeys.Sort: Constants.GitAPIParameterValues.Star,
            Constants.GitAPIParameterKeys.Order: Constants.GitAPIParameterValues.DecsOrder
            
        ]
        
        let request = URLRequest(url: appDelegate.gitAPIURLFromParameters(methodParameters as [String:AnyObject], withPathExtension: "/search/repositories"))
        
        
        let task = appDelegate.sharedSession.dataTask(with: request) { (data, response, error) in
            
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            guard let result = parsedResult["items"] as? [[String: AnyObject]] else{
                print("Cannot find nay item in reponse result")
                return
            }
            
            self.repositories = result
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
            
            
        }
        
        task.resume()
    }
    
    
}

extension EntranceViewController{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentify = "RepositoryViewCell"
        let repository = repositories?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentify) as! GitTableViewCell!
        
        cell?.gitNameLabel?.text = repository?["full_name"] as! String?
        cell?.gitContentLabel?.text = repository?["description"] as? String
        cell?.gitNumStarsLabel?.text = String(repository?["stargazers_count"] as! Int)  + " stars"
        
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if repositories != nil{
            return (repositories?.count)!
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.repository = self.repositories?[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(controller, animated: true)
    }
    
}

extension EntranceViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.GitAPIParameterValues.LanguageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let language = Constants.GitAPIParameterValues.LanguageArr[indexPath.row]
        
        // Set the name and image
        cell.languageLabel?.text = language
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        if(cell.languageLabel?.text != appDelegate.defualtLanguage){
            appDelegate.defualtLanguage = Constants.GitAPIParameterValues.LanguageArr[indexPath.row]
            self.getData()
            self.tableView.reloadData()
        }
    }
    
    

}

