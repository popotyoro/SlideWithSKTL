//
//  StreamMessageViewController.swift
//  RTM
//
//  Created by popota on 2018/10/18.
//  Copyright © 2018 Tagayasu. All rights reserved.
//

import Cocoa

class StreamMessageViewController: NSViewController {
    @IBOutlet weak var iconImageView: NSImageView!
    @IBOutlet weak var messageTextField: NSTextField!
    @IBOutlet weak var userNameTextField: NSTextField!
    
    var slackRTMService: SlackRTMService?
    var slackUserInfoService: SlackUserInfoService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slackUserInfoService = SlackUserInfoService.init(with: SlackDefinition.apiToken.rawValue)
    }
    
    override func viewWillAppear() {
        slackRTMService = SlackRTMService(with: SlackDefinition.rtmToken.rawValue)
        slackRTMService?.delegate = self
        slackRTMService?.connet()
    }
    
    func refreshView(image: NSImage, msg: String, name: String) {
            iconImageView.image = image
            userNameTextField.stringValue = name
            messageTextField.stringValue = msg
    }
}

extension StreamMessageViewController: SlackRTMServiceDelegate {
    
    func slackRTMService(_ slackRTMService: SlackRTMService, didRecive newMessage: SlackNewMessage) {
        guard let user = SlackUserDataStore.shared.getUserInfo(by: newMessage.userId) else { return }
        var messageText = newMessage.message
        let replacementUserIds = RegixUtil.extractSlackUserIds(by: newMessage.message)
        replacementUserIds.forEach { (userId) in
            guard let userInfo = SlackUserDataStore.shared.getUserInfo(by: userId),
                let range = messageText.range(of: "<@\(userId)>") else { return }
            messageText.replaceSubrange(range, with: "@\(userInfo.userName)")
        }
        self.refreshView(image: NSImage(byReferencing: user.photoImageUrl!), msg: messageText, name: user.userName)
    }
}

