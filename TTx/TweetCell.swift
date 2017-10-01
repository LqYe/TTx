//
//  TweetCell.swift
//  TTx
//
//  Created by Liqiang Ye on 9/29/17.
//  Copyright © 2017 Liqiang Ye. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    
    @IBOutlet weak var tweetDetailsView: UIView!
    
    var tweetDetailGroupViewYconstraint: NSLayoutConstraint!
    
    var tweet: Tweet! {
        didSet {
            
            var theTweet: Tweet! = tweet
            if let retweeted_status = tweet.retweeted_status {
                theTweet = retweeted_status
                retweetedLabel.isHidden = false
                retweetedLabel.text = "retweeted by \(tweet.user?.name ?? "Unknown")"
                NSLayoutConstraint.deactivate([tweetDetailGroupViewYconstraint])

            } else {
                retweetedLabel.isHidden = true
                NSLayoutConstraint.activate([tweetDetailGroupViewYconstraint])
            }
            
            let profileUrl = URL(string: (theTweet.user?.profile_image_url_https)!)!
            let formattedCreatedDate = Utils.convertTweetDateToTimeAgo(tweetDate: theTweet.created_at ?? "Unknown")
            
            profileImageView.setImageWith(profileUrl)
            nameLabel.text = theTweet.user?.name
            screenNameLabel.text = "@" + (theTweet.user?.screen_name ?? "")
            timestampLabel.text = formattedCreatedDate
            tweetTextLabel.text = theTweet.text

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.clipsToBounds = true
        //corner radius should be underlying frame height / 2
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2;
        profileImageView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileImageView.layer.borderWidth = 1;
        
        tweetDetailGroupViewYconstraint = NSLayoutConstraint(item: tweetDetailsView, attribute: .top, relatedBy: .equal, toItem: tweetDetailsView.superview, attribute: .top, multiplier: 1, constant: 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

