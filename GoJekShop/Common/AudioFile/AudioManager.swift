//
//  AudioManager.swift
//  GoJekProvider
//
//  Created by Rajes on 22/05/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import AVFoundation

class AudioManager {
    //MARK:- Audio Extension
    static var share = AudioManager()
    
    var alertPlayer: AVAudioPlayer?
    
    func startPlay() {
        
        let path = Bundle.main.path(forResource: "DriverrequestTone.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            alertPlayer = try AVAudioPlayer(contentsOf: url)
            alertPlayer?.numberOfLoops = -1
            alertPlayer?.play()
        } catch {
            print("\(error)")
        }
    }
    
    func stopSound() {
        
        if let _ = alertPlayer{
            alertPlayer?.stop()
        }
    }
}
