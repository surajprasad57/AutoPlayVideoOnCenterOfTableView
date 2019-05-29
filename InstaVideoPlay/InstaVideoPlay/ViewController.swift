//
//  ViewController.swift
//  InstaVideoPlay
//
//  Created by Suraj Prasad on 14/05/19.
//  Copyright © 2019 Suraj Prasad. All rights reserved.
//
import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    //MARK:- Globle Variable
    //datasources
    var videoUrlArray = ["http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4","http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4","http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4","http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4","http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4"]
    var videoTitleArray = ["For Bigger Blazes","For Bigger Escapes","For Bigger Fun","For Bigger Joyrides","For Bigger Meltdowns"]
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName: "VideoCell", bundle: nil), forCellReuseIdentifier: "VideoCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let visibleRows = tableView.indexPathsForVisibleRows else {return}
        let cell = self.tableView.cellForRow(at: (visibleRows[0])) as? VideoCell
        cell?.playerView.player?.play()
    }
}
//MARK:- Extension for TableView
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoUrlArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        let videoUrl = NSURL(string: videoUrlArray[indexPath.row])
        let avPlayer = AVPlayer(url: videoUrl! as URL)
        cell.videoTitleLabel.text = videoTitleArray[indexPath.row]
        cell.playerView?.playerLayer.player = avPlayer
        avPlayer.volume = 1.0
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 525
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = cell as? VideoCell else { return };
        videoCell.playerView.player?.pause();
        videoCell.playerView.player = nil;
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //video autoplay and pause logic
        guard let visibleRows = tableView.indexPathsForVisibleRows else {return}
        
        for indexPath in visibleRows{
            var cell = self.tableView.cellForRow(at: indexPath) as? VideoCell
            cell?.playerView.player?.pause()
            var center = CGPoint(x: tableView.center.x + tableView.contentOffset.x,y: tableView.center.y + tableView.contentOffset.y)
         
            guard var centerIndex = self.tableView.indexPathForRow(at: center) else {return}
            print("center point - \(center)")
            print("centerIndex - \(centerIndex.row)")
            let autoPlayCell = tableView.cellForRow(at: centerIndex) as? VideoCell
            autoPlayCell?.playerView.player?.play()
        }
    }
}
