//
//  TweetDetailsCell.swift
//  TTx
//
//  Created by Liqiang Ye on 9/30/17.
//  Copyright © 2017 Liqiang Ye. All rights reserved.
//

import UIKit

class TweetDetailsCell: UITableViewCell {

    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            
            let profileUrl = URL(string: (tweet.user?.profile_image_url_https)!)!
            let formattedCreatedDate = Utils.convertTweetDateToTimeAgo(tweetDate: tweet.created_at ?? "Unknown")
            
            profileImageView.setImageWith(profileUrl)
            nameLabel.text = tweet.user?.name
            screenNameLabel.text = "@" + (tweet.user?.screen_name ?? "")
            timestampLabel.text = formattedCreatedDate
            tweetTextLabel.text = tweet.text
            
            if !tweet.retweeted! {
                retweetedLabel.isHidden = true
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
