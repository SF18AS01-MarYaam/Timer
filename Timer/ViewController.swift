//
//  ViewController.swift
//  Timer
//
//  Created by Mariam Camara on 1/21/19.
//  Copyright © 2019 Mariam Camara. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer();
    var timer = Timer();
    var timer2 = Timer();
    var seconds: Int = 60;
    

    @IBOutlet weak var lblCounter: UILabel!
    
    @IBOutlet weak var btnStart: UIButton!
    
    @IBOutlet weak var btnStop: UIButton!
    
    @IBOutlet weak var btnReset: UIButton!
    
    var isTimerRunning = false;
    var resumeTapped = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        btnStop?.isEnabled = false;
        playSound();
    }
    

   

    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            fireSound()
            self.btnStart?.isEnabled = false
        }
    }
    
    @objc func playSound(){
        let path = Bundle.main.path(forResource: "click.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    @objc func fireSound(){
        timer2 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(playSound), userInfo: nil, repeats: true)
    }
    
    @objc func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        btnStop?.isEnabled = true
    }
    
    
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            timer2.invalidate()
            isTimerRunning = false
            self.resumeTapped = true
            self.btnStop.setTitle("Resume",for: .normal)
        } else {
            runTimer()
            fireSound()
            self.resumeTapped = false
            isTimerRunning = true
            self.btnStop.setTitle("Pause",for: .normal)
        }
    }
    
    
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        timer2.invalidate()
        seconds = 60
        lblCounter.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false

        btnStart?.isEnabled = true;
        btnStop?.isEnabled = false;
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            timer2.invalidate()
            //Send alert to indicate time's up.
        } else {
            seconds -= 1
            lblCounter.text = timeString(time: TimeInterval(seconds))
        }
    }
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }

    
        
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

