//
//  RegixUtil.swift
//  RTM
//
//  Created by popota on 2018/10/21.
//  Copyright © 2018 Tagayasu. All rights reserved.
//

import Foundation

struct RegixUtil {
    static func extractSlackUserIds(by message: String) -> [String] {
        
        let pattern = "<@[\\w]+>"
        let regix = try! NSRegularExpression(pattern: pattern)
        let match = regix.matches(in: message, range: NSRange(location: 0, length: message.count))
        
        return match.map { (textCheckResult) -> String in
            let matchString = message[Range(textCheckResult.range, in: message)!]
            return String(matchString[matchString.index(matchString.startIndex, offsetBy: 2)...matchString.index(matchString.endIndex, offsetBy: -2)])
        }
    }
}
