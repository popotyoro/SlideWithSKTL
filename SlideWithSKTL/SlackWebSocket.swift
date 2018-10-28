//
//  CustomWebSocket.swift
//  RTM
//
//  Created by popota on 2018/10/18.
//  Copyright © 2018 Tagayasu. All rights reserved.
//

import Foundation
import SKRTMAPI
import Starscream

class SlackWebSocket: RTMWebSocket {
    
    private var webSocket: WebSocket?
    
    required init(){}
    
    var delegate: RTMDelegate?
    
    var customDelegate: SlackWebsocketDelegate?
    
    func connect(url: URL) {
        self.webSocket = WebSocket(url: url)
        self.webSocket?.delegate = self
        self.webSocket?.connect()
    }
    
    func disconnect() {
        print("disconneted")
    }
    
    func sendMessage(_ message: String) throws {
        print("msg")
    }
}

extension SlackWebSocket: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        print("connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("disconnected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: text.data(using: .utf8)!, options: []) as? [String: Any] else { return }
            guard let msgType = json["type"] as? String, msgType == "message" else { return }
            
            guard let message = json["text"] as? String else { return }
            guard let userId = json["user"] as? String else { return }
            
            customDelegate?.slackWebsocket(self, didRecive: SlackNewMessage(message: message.replacingOccurrences(of: "\n", with: " "), userId: userId))
        } catch {
            print(error)
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print(data)
    }
}

protocol SlackWebsocketDelegate {
    func slackWebsocket(_ slackWebSocket: SlackWebSocket, didRecive newMessage: SlackNewMessage)
}

