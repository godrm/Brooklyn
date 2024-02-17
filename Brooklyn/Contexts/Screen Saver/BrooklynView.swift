//
//  BrooklynView.swift
//  Brooklyn
//
//  Created by Pedro Carrasco on 30/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation
import ScreenSaver
import AVKit
import OSLog

// MARK: - BrooklynView
final class BrooklynView: ScreenSaverView {

    // MARK: Local Typealias
    typealias Static = BrooklynView
    
    // MARK: Constant
    private enum Constant {
        static let secondPerFrame = 1.0 / 30.0
        static let backgroundColor = NSColor(red: 0.00, green: 0.01, blue: 0.00, alpha:1.0)
    }
    
    // MARK: Outlets
    private let videoLayer = AVPlayerLayer()
    
    // MARK: Properties
    private let manager = BrooklynManager(mode: .screensaver)
    private lazy var preferences = PreferencesWindowController(windowNibName: PreferencesWindowController.identifier)
    
    private let log = Logger(subsystem: "kr.codesquad.brooklyn", category: "ScreenSaverView")

    // MARK: Initialization
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        log.error("init with coder")
        animationTimeInterval = Constant.secondPerFrame
        configure()
    }
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        log.error("init with frame \(isPreview)")
        animationTimeInterval = Constant.secondPerFrame
        configure()
    }
    
    deinit {
        log.error("deinit")

    }
}

// MARK: - Lifecycle
extension BrooklynView {
    
    override func startAnimation() {
        super.startAnimation()
        log.error("startAnimation")
        setupLayer()
        manager.player.play()
    }
    
    override func stopAnimation() {
        super.stopAnimation()
        log.error("stopAnimation")
        manager.player.pause()
        videoLayer.player = nil
    }
}

// MARK: - Configuration
private extension BrooklynView {
    
    func configure() {
        defineLayer()
        setupLayer()
    }
    
    func defineLayer() {
        wantsLayer = true
        defineVideoLayer()
        layer = videoLayer
    }
    
    func setupLayer() {
        videoLayer.player = manager.player
    }
}

// MARK: - Define Layers
private extension BrooklynView {

    func defineVideoLayer() {
        videoLayer.frame = bounds
        videoLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        videoLayer.needsDisplayOnBoundsChange = true
        videoLayer.contentsGravity = .resizeAspect
        videoLayer.backgroundColor = Constant.backgroundColor.cgColor
    }
}

// MARK: - Preferences
extension BrooklynView {

    override var hasConfigureSheet: Bool {
        return true
    }

    override var configureSheet: NSWindow? {
        return preferences.window
    }
}
