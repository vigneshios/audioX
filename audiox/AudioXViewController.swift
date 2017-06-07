//
//  AudioXViewController.swift
//  audiox
//
//  Created by vignesh on 6/7/17.
//  Copyright © 2017 vignesh. All rights reserved.
//

import UIKit
import AVFoundation
class AudioXViewController: UIViewController {

    @IBOutlet weak var trackTitle: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    var trackPlayer : AVPlayer?
    
    
    func getUrl(url:URL){
        trackPlayer = AVPlayer(url: url)
        trackTitle.text = url.lastPathComponent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "http://tamilmp3play.com/2007/Vettayadu%20Vilayadu/PaarthaMudhal.mp3"){
        
            getUrl(url: url)
        }
    
    }

    
    
    
    @IBAction func playbuttonAction(_ sender: Any) {
        
        if let player = trackPlayer {
            if player.rate == 0 {
                player.play()
                self.playButton.setTitle("PAUSE", for: .normal)
            }
            else {
                player.pause()
                self.playButton.setTitle("PLAY", for: .normal)
            }
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
