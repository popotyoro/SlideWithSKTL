//
//  SlackUserDataStore.swift
//  RTM
//
//  Created by popota on 2018/10/20.
//  Copyright © 2018 Tagayasu. All rights reserved.
//

import Foundation

class SlackUserDataStore {
    
    private var userInfoList: [SlackUserInfo]?
    
    static let shared = SlackUserDataStore()
    
    private init() {
        let service = SlackUserInfoService.init(with: SlackDefinition.apiToken.rawValue)
        service.requestAllSlackUserInfo { (userInfoList) in
            self.userInfoList = userInfoList
        }
    }
    
    func getUserInfo(by userId: String) -> SlackUserInfo? {
        return userInfoList?.filter({ (user) -> Bool in
            return user.userId == userId
        }).first
    }
}
