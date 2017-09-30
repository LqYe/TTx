//
//  TweetViewController.swift
//  TTx
//
//  Created by Liqiang Ye on 9/30/17.
//  Copyright © 2017 Liqiang Ye. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tweetDetailsTableview: UITableView!
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tweetDetailsTableview.estimatedRowHeight = 100
        tweetDetailsTableview.rowHeight = UITableViewAutomaticDimension
        
        tweetDetailsTableview.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tweetDetailsTableview.dequeueReusableCell(withIdentifier: "TweetDetailsCell") as? TweetDetailsCell else {
            return UITableViewCell()
        }
        
        cell.tweet = tweet
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell  = tweetDetailsTableview.cellForRow(at: indexPath) as! TweetDetailsCell
        cell.selectionStyle = .none
        
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
