//
//  SlackRTMService.swift
//  RTM
//
//  Created by popota on 2018/10/18.
//  Copyright © 2018 Tagayasu. All rights reserved.
//

import Foundation
import SKRTMAPI
import Starscream

class SlackRTMService {
    
    let token: String
    var rtm: SKRTMAPI?
    
    var delegate: SlackRTMServiceDelegate?
    
    init(with token: String) {
        self.token = token
    }
    
    func connet() {
        let rtmWebSocket = SlackWebSocket()
        rtmWebSocket.delegate = self
        rtmWebSocket.customDelegate = self
        rtm = SKRTMAPI(withAPIToken: token, rtm: rtmWebSocket)
        rtm?.connect()
    }
}

protocol SlackRTMServiceDelegate {
    func slackRTMService(_ slackRTMService: SlackRTMService, didRecive newMessage: SlackNewMessage)
}

// MARK: - RTMDelegate
extension SlackRTMService: RTMDelegate {
    func didConnect() {
        
    }
    
    func disconnected() {
        
    }
    
    func receivedMessage(_ message: String) {
        print(message)
    }
}

extension SlackRTMService: SlackWebsocketDelegate {
    func slackWebsocket(_ customWebsocket: SlackWebSocket, didRecive newMessage: SlackNewMessage) {
        delegate?.slackRTMService(self, didRecive: newMessage)
    }
}

