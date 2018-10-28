//
//  MainContentViewController.swift
//  RTM
//
//  Created by popota on 2018/10/18.
//  Copyright © 2018 Tagayasu. All rights reserved.
//

import Cocoa

class MainContentViewController: NSViewController {
    
    @IBOutlet weak var streamMessageView: NSView!
    @IBOutlet weak var googleSlideWebView: NSView!
    
    var streamMessageViewController: StreamMessageViewController!
    var googleSlideWebViewController: GoogleSlideWebViewController!
    
    override func loadView() {
        super.loadView()
        streamMessageViewController = NSStoryboard(name: "StreamMessageView", bundle: nil).instantiateInitialController() as? StreamMessageViewController
        addChild(streamMessageViewController)
        streamMessageViewController.view.frame = streamMessageView.bounds
        streamMessageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        streamMessageView.addSubview(streamMessageViewController.view)
        
        googleSlideWebViewController = NSStoryboard(name: "GoogleSlideWebView", bundle: nil).instantiateInitialController() as? GoogleSlideWebViewController
        addChild(googleSlideWebViewController)
        googleSlideWebViewController.view.frame = googleSlideWebView.bounds
        googleSlideWebViewController.view.translatesAutoresizingMaskIntoConstraints = false
        googleSlideWebView.addSubview(googleSlideWebViewController.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        setConstraints()
    }
}

private extension MainContentViewController {
    private func setConstraints() {
        
        streamMessageView.leadingAnchor.constraint(equalTo: streamMessageViewController.view.leadingAnchor, constant: 0).isActive = true
        streamMessageView.trailingAnchor.constraint(equalTo: streamMessageViewController.view.trailingAnchor, constant: 0).isActive = true
        streamMessageView.bottomAnchor.constraint(equalTo: streamMessageViewController.view.bottomAnchor, constant: 0).isActive = true
        streamMessageView.topAnchor.constraint(equalTo: streamMessageViewController.view.topAnchor, constant: 0).isActive = true
        
        googleSlideWebView.leadingAnchor.constraint(equalTo: googleSlideWebViewController.view.leadingAnchor).isActive = true
        googleSlideWebView.trailingAnchor.constraint(equalTo: googleSlideWebViewController.view.trailingAnchor).isActive = true
        googleSlideWebView.bottomAnchor.constraint(equalTo: googleSlideWebViewController.view.bottomAnchor).isActive = true
        googleSlideWebView.topAnchor.constraint(equalTo: googleSlideWebViewController.view.topAnchor).isActive = true
    }
}
