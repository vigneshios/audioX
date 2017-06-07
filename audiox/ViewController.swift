//
//  ViewController.swift
//  audiox
//
//  Created by vignesh on 6/7/17.
//  Copyright © 2017 vignesh. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var videoPlayer : AVPlayer!
    var videoPlayerLayer : AVPlayerLayer!
  
    //IBOutlets:
    
    @IBOutlet weak var UserNameField: UITextField!
    
    @IBOutlet weak var PasswordField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setVideoBackGround()
        
        
    }

    func setVideoBackGround() {
        
       guard let path = Bundle.main.url(forResource: "bckgnd", withExtension: "mp4") else { return }
        self.videoPlayer = AVPlayer.init(url: path)
        self.videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        videoPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPlayerLayer.frame = view.layer.frame
        
        videoPlayer.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        videoPlayer.play()
        view.layer.insertSublayer(videoPlayerLayer, at: 0)
        
        
       NotificationCenter.default.addObserver(self, selector: #selector(playcontinuously(Notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayer.currentItem)
    }
    
    
    
    
    func playcontinuously(Notification:NSNotification) {
     
        videoPlayer.seek(to: kCMTimeZero)
        
    }
    
    
    @IBAction func LoginButttonAction(_ sender: Any) {
        
        let username = UserNameField.text
        let password = PasswordField.text
        
        if (username == "" || password == "") {
            
            return
        }
        
        logginUser()
        
    }
    
    func logginUser () {
        
        
        let parameters = ["username": UserNameField.text, "Password": PasswordField.text]
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        guard let httpbody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return }
        request.httpBody = httpbody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                print(data)
                do {
                    
                    let json =  try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch {
                    print(error)
                }
             }
            
            
            if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                print(response)
                
                DispatchQueue.main.async {
                    
                    self.performSegue(withIdentifier: "login", sender: nil)
                }
                
            }

            
            
        }.resume()
        
     }
    

}



