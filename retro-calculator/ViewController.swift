//
//  ViewController.swift
//  retro-calculator
//
//  Created by 李宝明 on 16/8/15.
//  Copyright © 2016年 李宝明. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    enum Operation:String {
        
        case Add = "+"
        case Substract = "-"
        case Multiply = "x"
        case Divide = "/"
        case Empty = ""
        case Equal = "="
    }
    
    
    @IBOutlet weak var outputLbl:UILabel!
    
    var btSound:AVAudioPlayer!
    
    var leftValStr = ""
    var rightValStr = ""
    
    var runningNumber = ""
    
    var result:String = ""
    
    var currentOperator:Operation = Operation.Empty
    
    
    

    override func viewDidLoad() {
        
                super.viewDidLoad()
                
                let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
                
                let soundUrl = NSURL(fileURLWithPath: path!)
                
                do {
                    
                    try btSound = AVAudioPlayer(contentsOfURL: soundUrl)
                    btSound.prepareToPlay()
               
                    }catch let err as NSError {
                        
                        print(err.debugDescription)
                    }
        
                }

    
    
    @IBAction func onClearPressed(sender: UIButton) {
        
        playSound()
        
        outputLbl.text = "0"
        
        currentOperator = Operation.Empty
        
        leftValStr = ""
        
        rightValStr = ""
        
        runningNumber = ""
        
        
    }
    
    
    @IBAction func numberPressed(btn:UIButton!){
        
        playSound()
        
        runningNumber = runningNumber + "\(btn.tag)"
        
        outputLbl.text = runningNumber
        
    }
    
    
    @IBAction func onDividePressed(sender: UIButton) {
        
        processOperator(Operation.Divide)
    }
    
    
    @IBAction func onMultiplayPressed(sender: UIButton) {
        
        processOperator(Operation.Multiply)
    }
    
    
    
    @IBAction func onSubstractPressed(sender: UIButton) {
        
        processOperator(Operation.Substract)
    }
    
    
    @IBAction func onAddPressed(sender: UIButton) {
        
        processOperator(Operation.Add)
    }
    
    
    @IBAction func onEqualPressed(sender: UIButton) {
        
        processOperator(currentOperator)
    }
    

    func processOperator (op:Operation){
        
        playSound()
        
        if runningNumber != "" {
            
            if currentOperator != Operation.Empty {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperator == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperator == Operation.Divide {
                    result = "\(Double(leftValStr)!/Double(rightValStr)!)"
                } else if currentOperator == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperator == Operation.Substract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                
                leftValStr = result
                currentOperator = op
                
                outputLbl.text = result
                
            }
            else {
                
                leftValStr = runningNumber
                runningNumber = ""
                outputLbl.text = runningNumber
                currentOperator = op
                 }
        
        
        }
        else {
            currentOperator = op
        }
        
        
    }
    
    
    func playSound(){
        
        if btSound.playing {
            btSound.stop()
        }
        
        btSound.play()
        
        
        
    }
    
    
    
}

