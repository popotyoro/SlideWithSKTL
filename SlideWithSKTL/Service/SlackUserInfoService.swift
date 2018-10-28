//
//  SlackUserInfoService.swift
//  RTM
//
//  Created by popota on 2018/10/18.
//  Copyright © 2018 Tagayasu. All rights reserved.
//

import Cocoa
import Alamofire

struct SlackUserInfoService  {
    
    let token: String
    
    init(with token: String) {
        self.token = token
    }
    
    func requestSlackUserInfo(by userId: String, completion: ((SlackUserInfo) -> Void)?) {
        
        let parameter: Parameters = [
            "token": token,
            "user": userId
        ]
        
        Alamofire.request("https://slack.com/api/users.info", parameters: parameter).responseJSON { (response) in
            guard let json = response.result.value as? [String: Any] else { return }
            guard let user = json["user"] as? [String: Any] else { return }
            guard let userId = user["id"] as? String else { return }
            guard let userName = user["real_name"] as? String else { return }
            guard let profile = user["profile"] as? [String: Any] else { return }
            guard let imageUrl = profile["image_192"] as? String else { return }
            
            completion?(SlackUserInfo(userId: userId, userName: userName, photoImageUrl: URL(string: imageUrl)))
        }
    }
    
    func requestAllSlackUserInfo(completion: (([SlackUserInfo]) -> Void)?) {
        
        let parameter: Parameters = [
            "token": token
        ]
        
        Alamofire.request("https://slack.com/api/users.list", parameters: parameter).responseJSON { (response) in
            guard let json = response.result.value as? [String: Any] else { return }
            guard let members = json["members"] as? [[String: Any]] else { return }
            
            completion?(members.compactMap({ (user) -> SlackUserInfo? in
                guard let userId = user["id"] as? String else { return nil}
                guard let userName = user["real_name"] as? String else { return nil}
                guard let profile = user["profile"] as? [String: Any] else { return nil}
                guard let imageUrl = profile["image_192"] as? String else { return nil}
                return SlackUserInfo(userId: userId, userName: userName, photoImageUrl: URL(string: imageUrl))
            }))
        }
    }
}
