//
//  ViewController.swift
//  RetroCalc
//
//  Created by Lawrence Johnson on 12/27/15.
//  Copyright © 2015 Lawrence Johnson. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var display: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    // Working Variables
    
    var runningNumber: String = ""
    var leftVal: String = ""
    var rightVal: String = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Action buttons
    @IBAction func onNumberPress(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        display.text = runningNumber
    }
    
    @IBAction func onDividePress(sender: AnyObject) {
        proccessOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPress(sender: AnyObject) {
        proccessOperation(Operation.Multiply)
    }
    
    @IBAction func onAddPress(sender: AnyObject) {
        proccessOperation(Operation.Add)
    }
    
    @IBAction func onSubtractPress(sender: AnyObject) {
        proccessOperation(Operation.Subtract)
    }
    
    @IBAction func onEqualPress(sender: AnyObject) {
        proccessOperation(currentOperation)
    }
    
    @IBAction func clearDisplay(sender: AnyObject) {
        display.text = ""
        runningNumber = ""
        leftVal = ""
        rightVal = ""
        currentOperation = Operation.Empty
    }
    
    // Helper functions
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func proccessOperation(op: Operation) {
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                playSound()
                rightVal = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftVal)! * Double(rightVal)!)"
                }
                else if currentOperation == Operation.Divide {
                    result = "\(Double(leftVal)! / Double(rightVal)!)"
                }
                else if currentOperation == Operation.Add {
                    result = "\(Double(leftVal)! + Double(rightVal)!)"
                }
                else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftVal)! - Double(rightVal)!)"
                }
                
                leftVal = result
                rightVal = ""
                display.text = result
            }
            
            currentOperation = op
            
        }
        else {
            playSound()
            leftVal = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
}