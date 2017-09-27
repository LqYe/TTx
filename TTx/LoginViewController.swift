//
//  LoginViewController.swift
//  TTx
//
//  Created by Liqiang Ye on 9/26/17.
//  Copyright © 2017 Liqiang Ye. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginButtonClicked(_ sender: Any) {
        
        //create a API client
        let twitterClient = BDBOAuth1SessionManager(baseURL: AppConstants.APIConstants.accessBaseUrl, consumerKey: AppConstants.APIConstants.consumerKey, consumerSecret: AppConstants.APIConstants.consumerSecret)
        
        //clear keychains and previous sessions
        twitterClient?.deauthorize()
        
        //request temporary token
        twitterClient?.fetchRequestToken(withPath: AppConstants.APIConstants.requestTokenPath, method: "POST", callbackURL: URL(string: "TTxapp://oauth"), scope: nil, success: { (requestToken : BDBOAuth1Credential!) -> Void in

            //after getting temporary token, directs user to authorize page
            //once user authorizes, it should be redirected back to the client app.
            let authorizeUrl  = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token!)")!

            //now open the authorize web page
            UIApplication.shared.open(authorizeUrl, options: [:], completionHandler: nil)
            
        }, failure: { (error: Error!) -> Void in
            print("Error: \(error.localizedDescription)")
        })
        
    }
    
}
