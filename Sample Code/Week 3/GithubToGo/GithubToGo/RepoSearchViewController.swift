//
//  RepoSearchViewController.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/13/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class RepoSearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
  
  let githubService = GithubService()

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  var results = [Repository]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.tableView.dataSource = self
      self.searchBar.delegate = self
        // Do any additional setup after loading the view.
    }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.results.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("SearchRepoCell", forIndexPath: indexPath) as! UITableViewCell
    
    let repo = self.results[indexPath.row]
    cell.textLabel?.text = repo.name
    
    return cell
    
  }
  
  //MARK: UISearchBarDelegate
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    self.githubService.fetchReposForSearch(searchBar.text, completionHandler: { (repos, error) -> (Void) in
      if repos != nil {
        println(repos!.count)
        self.results = repos!
        self.tableView.reloadData()
      }
    })
    
  }
  
  

}
