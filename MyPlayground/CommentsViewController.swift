//
//  CommentsViewController.swift
//  MyPlayground
//
//  Created by Mitchell Gerber on 11/7/17.
//  Copyright © 2017 Mitchell Gerber. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet weak var postTitle: UILabel!

    public var tempTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.postTitle.text = self.tempTitle
        self.navigationItem.title = "new page"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonOnPress(_ sender: UIButton) {
        let commentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        commentsViewController.tempTitle = "nested page"
        self.navigationController?.pushViewController(commentsViewController as UIViewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
