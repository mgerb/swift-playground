//
//  ViewController.swift
//  MyPlayground
//
//  Created by Mitchell Gerber on 11/2/17.
//  Copyright © 2017 Mitchell Gerber. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var redditTableView: UITableView!
    @IBOutlet weak var navHeader: UINavigationItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var redditPosts: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getRedditPosts()
        
        redditTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        redditTableView.separatorInset = UIEdgeInsets.zero
        redditTableView.separatorColor = UIColor.cyan
        redditTableView.showsVerticalScrollIndicator = false
        redditTableView.keyboardDismissMode = .onDrag
        
        print(self.searchBar.frame.size.height)
        DispatchQueue.main.async{
                self.redditTableView.setContentOffset(CGPoint(x: 0, y: self.searchBar.bounds.height - self.navigationController!.navigationBar.frame.height), animated: true)
        }

        self.navHeader.title = "test123"
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addTapped))
        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(self.playTapped))
        
        self.navHeader.rightBarButtonItems = [add, play]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getRedditPosts() {
        Alamofire.request("https://www.reddit.com/r/all.json").responseJSON{ res in
            
            if let json = res.result.value {
                let object = JSON(json)["data"]["children"].arrayValue

                object.forEach({ o in
                    if let title = o["data"]["title"].string {
                        self.redditPosts.append(title)
                    }
                })
                
                DispatchQueue.main.async{
                        self.redditTableView?.reloadData()
                }

            }
        }
    }
    
    @objc func addTapped() {
        print("add")
    }
    
    @objc func playTapped() {
        print("play")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // deselect row right after selecting
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "redditPostCell", for: indexPath) as! RedditPostCell
        
        cell.cellTitle.text = redditPosts[indexPath.row]
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.cyan
        cell.selectedBackgroundView = bgColorView

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { action, _ in
            print(action)
        }
        
        let editAction = UITableViewRowAction(style: .destructive, title: "Edit") { action, _ in
            print(action)
        }

        return [deleteAction, editAction]
    }

}

