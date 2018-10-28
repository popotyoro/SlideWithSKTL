//
//  CustomImageView.swift
//  RTM
//
//  Created by popota on 2018/10/27.
//  Copyright © 2018 Tagayasu. All rights reserved.
//

import Cocoa

@IBDesignable
class CustomImageView: NSImageView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.layer?.cornerRadius = 40
    }
    
}
