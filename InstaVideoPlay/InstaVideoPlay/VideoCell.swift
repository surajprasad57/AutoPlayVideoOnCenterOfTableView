//
//  VideoCell.swift
//  InstaVideoPlay
//
//  Created by Suraj Prasad on 20/05/19.
//  Copyright © 2019 Suraj Prasad. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    //MARK:- IBOutlets
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var playerView: PlayerViewClass!
    @IBOutlet weak var volumeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    //MARK:- Global Variables
    var likeButtonClickCount = 0
    var volumeButtonTapCount = 0
    //MARK:- LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //MARK:- IBActions
    @IBAction func tapLikeButton(_ sender: Any) {
        likeButtonClickCount += 1
        
        print("like button tapped")
        if likeButtonClickCount % 2 != 0 {
            print("odd click")
            likeButton.setImage(UIImage(named: "redHeart"), for: .normal)
        } else {
            print("even click")
            likeButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
        }
    }
    
    @IBAction func tapMuteUnmute(_ sender: Any) {
        volumeButtonTapCount += 1
        
        if volumeButtonTapCount%2 != 0 {
            
            volumeButton.setImage(UIImage(named: "mute2"), for: .normal)
            playerView.player?.volume = 0.0
        }
        else {
            volumeButton.setImage(UIImage(named: "volume"), for: .normal)
            playerView.player?.volume = 1.0
        }
    }
}
