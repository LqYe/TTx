//
//  HomeTimelineViewController.swift
//  TTx
//
//  Created by Liqiang Ye on 9/29/17.
//  Copyright © 2017 Liqiang Ye. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tweetsTableView: UITableView!
    var tweets: [Tweet] = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetsTableView.estimatedRowHeight = 100
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance!.getHomeTimeline(success: { (homeTimeline: [Tweet]!) in
            
            print("***************Start Printing Hometimeline************")
            print(homeTimeline)
            self.tweets = homeTimeline
            
            self.tweetsTableView.reloadData()
            
        }, failure: { (error: Error!) -> Void in
            print("Error: \(error.localizedDescription)")
        })
        
        //add pull to refresh
        //1. initialize a UI refresh control
        let refreshControl = UIRefreshControl()
        
        //2. implment an action to update the list - see refreshControlAction
        
        //3. bind the action to the refresh control
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        //4. insert the refresh control into the list
        tweetsTableView.insertSubview(refreshControl, at: 0)
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl){
        
        TwitterClient.sharedInstance!.getHomeTimeline(success: { (homeTimeline: [Tweet]!) in
            
            print("***************Pull to refresh Hometimeline************")
            self.tweets = homeTimeline
            refreshControl.endRefreshing()
            self.tweetsTableView.reloadData()

        }, failure: { (error: Error!) -> Void in
            print("Error: \(error.localizedDescription)")
            refreshControl.endRefreshing()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButtonClicked(_ sender: Any) {
        
        TwitterClient.sharedInstance!.logout()
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return 1
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "TweetCell") as? TweetCell else {
            return UITableViewCell()
        }
        
        cell.tweet = tweets[indexPath.section]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell  = tweetsTableView.cellForRow(at: indexPath) as! TweetCell
        cell.selectionStyle = .none
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dvc = segue.destination as! TweetDetailsViewController
        let indexPath = tweetsTableView.indexPath(for: sender as! UITableViewCell)!
        let tweetCell = tweetsTableView.cellForRow(at: indexPath) as! TweetCell
        dvc.tweet = tweetCell.tweet
    }
 
    
}
