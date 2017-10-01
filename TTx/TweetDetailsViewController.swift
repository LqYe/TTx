//
//  TweetViewController.swift
//  TTx
//
//  Created by Liqiang Ye on 9/30/17.
//  Copyright © 2017 Liqiang Ye. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    
    
    
    
    
    var tweet: Tweet!
    
    var tweetUpdateHandler: (Tweet) -> Void = { (tweet) in }
    
    //setter
    func prepare(tweet: Tweet?, tweetUpdateHandler: @escaping (Tweet) -> Void) {
        
        if let tweet = tweet {
            self.tweet = tweet
        }
        
        self.tweetUpdateHandler = tweetUpdateHandler
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let profileUrl = URL(string: (tweet.user?.profile_image_url_https)!)!
        let formattedCreatedDate = Utils.convertTweetDateToTimeAgo(tweetDate: tweet.created_at ?? "Unknown")
        
        profileImageView.setImageWith(profileUrl)
        nameLabel.text = tweet.user?.name
        screenNameLabel.text = "@" + (tweet.user?.screen_name ?? "")
        timestampLabel.text = formattedCreatedDate
        tweetTextLabel.text = tweet.text
        
        retweetCountLabel.text = "\(tweet.retweet_count ?? 0)"
        likeCountLabel.text = "\(tweet.favorite_count ?? 0)"
        
        if tweet.favorited != nil && tweet.favorited! {
            likeButton.setImage(UIImage(named: "liked"), for: UIControlState.normal)
        }

        if tweet.retweeted != nil && tweet.retweeted! {
            retweetButton.setImage(UIImage(named: "retweeted"), for: UIControlState.normal)
        }
        
//        if !tweet.retweeted! {
//            retweetedLabel.isHidden = true
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        
    }
    
    @IBAction func onLikeButtonClicked(_ sender: Any) {
        let id = tweet.id ?? 0

        if tweet.favorited == nil || !tweet.favorited! {
            TwitterClient.sharedInstance!.postLike(id: id, action: "create", success: {
                print("Successfully Liked a Tweet \(id)")
                self.tweet.favorited = true
                self.likeButton.setImage(UIImage(named: "liked"), for: UIControlState.normal)
                self.tweet.favorite_count = (self.tweet.favorite_count ?? 0) + 1
                self.likeCountLabel.text = "\(self.tweet.favorite_count!)"
            }, failure: { (error: Error!) in
                print("Error: \(error.localizedDescription)")
            })
        } else {
            TwitterClient.sharedInstance!.postLike(id: id, action: "destroy", success: {
                print("Successfully Unliked a Tweet \(id)")
                self.tweet.favorited = false
                self.likeButton.setImage(UIImage(named: "like"), for: UIControlState.normal)
                self.tweet.favorite_count = (self.tweet.favorite_count ?? 1) - 1
                self.likeCountLabel.text = "\(self.tweet.favorite_count!)"
            }, failure: { (error: Error!) in
                print("Error: \(error.localizedDescription)")
            })
        }
    }
    
    
    @IBAction func onRetweetButtonClicked(_ sender: Any) {
        
        let id = tweet.id ?? 0
        
        if tweet.retweeted  == nil || !tweet.retweeted! {
            TwitterClient.sharedInstance!.postRetweet(id: id, success: {
                print("Successfully Retweeted a Tweet \(id)")
                self.tweet.retweeted = true
                self.retweetButton.setImage(UIImage(named: "retweeted"), for: UIControlState.normal)
                self.tweet.retweet_count = (self.tweet.retweet_count ?? 0) + 1
                self.retweetCountLabel.text = "\(self.tweet.retweet_count!)"
            }, failure: { (error: Error!) in
                print("Error: \(error.localizedDescription)")
            })
        }
        
    }
    
    @IBAction func onReplyButtonClicked(_ sender: Any) {
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
