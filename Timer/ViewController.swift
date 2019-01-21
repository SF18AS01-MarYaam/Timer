//
//  ViewController.swift
//  Timer
//
//  Created by Mariam Camara on 1/21/19.
//  Copyright © 2019 Mariam Camara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer();
    var seconds: Int = 60;

    @IBOutlet weak var lblCounter: UILabel!
    
    @IBOutlet weak var btnStart: UIButton!
    
    @IBOutlet weak var btnStop: UIButton!
    
    @IBOutlet weak var btnReset: UIButton!
    
    var isTimerRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        btnStop?.isEnabled = false
    }


    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            self.btnStart?.isEnabled = false
        }
    }
    
    @objc func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        btnStop?.isEnabled = true
    }
    
    
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            isTimerRunning = false
            self.resumeTapped = true
            self.btnStop.setTitle("Resume",for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            isTimerRunning = true
            self.btnStop.setTitle("Pause",for: .normal)
        }
    }
    
    
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        seconds = 60
        lblCounter.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false

        btnStart?.isEnabled = true;
        btnStop?.isEnabled = false;
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
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

