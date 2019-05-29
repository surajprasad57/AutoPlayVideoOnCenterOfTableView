
//
//  VideoPlayerView.swift
//  InstaVideoPlay
//
//  Created by Suraj Prasad on 14/05/19.
//  Copyright © 2019 Suraj Prasad. All rights reserved.
//

import UIKit
import AVKit

class PlayerViewClass: UIView {
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
}
