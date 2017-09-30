//
//  Tweet.swift
//  TTx
//
//  Created by Liqiang Ye on 9/29/17.
//  Copyright © 2017 Liqiang Ye. All rights reserved.
//

import Foundation

struct Tweet: Decodable {
    
    let text: String?
    let created_at: String?
    let retweet_count: Int?
    let retweeted: Bool?
    let source: String?
    //let reply_count: Int?
    let favorite_count: Int?
    
    
    //user object
    let user: User?
    
    
    
}
