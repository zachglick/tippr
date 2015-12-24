//
//  ViewController.swift
//  tippr
//
//  Created by Zach Glick on 12/21/15.
//  Copyright © 2015 Zach Glick. All rights reserved.
//

import UIKit
var percents = [18.0 , 20.0, 25.0]
var index = 1
var curr = true

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.title = "tippr"
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        tipControl.selectedSegmentIndex = 1
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        /*if parent == nil {
            print("bingooo")
            
        }*/
        print(parent?.title)
        for i in 0...2{
            tipControl.setTitle(stringTip(percents[i]), forSegmentAtIndex: i)
        }
        tipControl.selectedSegmentIndex = index
    }


    @IBAction func onEditingChanged(sender: AnyObject) {
        
        var tipPercentages = [percents[0]/100, percents[1]/100, percents[2]/100]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text!).doubleValue
        var tip = billAmount * tipPercentage
        var total = tip + billAmount
        
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        tipLabel.text = String(format: "$%.2f", tip)
        
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func doubleTip(stringTip: String) -> Double{
        var intStr: String = stringTip.substringToIndex(stringTip.endIndex.advancedBy(-1))
        return NSString(string: intStr).doubleValue
    }
    func stringTip(doubleTip: Double) -> String {
        return String(format:"%.0f",doubleTip) + "%"
    }
    
    
}

