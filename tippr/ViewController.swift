//
//  ViewController.swift
//  tippr
//
//  Created by Zach Glick on 12/21/15.
//  Copyright © 2015 Zach Glick. All rights reserved.
//

import UIKit


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
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(18.0, forKey: "tip0")
        defaults.setDouble(20.0, forKey: "tip1")
        defaults.setDouble(25.0, forKey: "tip2")
        defaults.setInteger(1, forKey: "index")
        defaults.setBool(true, forKey: "curr")
        defaults.synchronize()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()

        for i in 0...2 {
            tipControl.setTitle(stringTip(defaults.doubleForKey("tip\(i)")), forSegmentAtIndex: i)
        }
        tipControl.selectedSegmentIndex = defaults.integerForKey("index")
        onEditingChanged(billField)
        
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentages = [defaults.doubleForKey("tip0")/100, defaults.doubleForKey("tip1")/100, defaults.doubleForKey("tip2")/100]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text!).doubleValue
        
        
        var tip = billAmount * tipPercentage
        var total = tip + billAmount
        
        //if(false){
        //tipLabel.text = "$\(tip)"
        //totalLabel.text = "$\(total)"
        if(defaults.boolForKey("curr") == false){
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
        }
        else{
            var formatter = NSNumberFormatter()
            formatter.locale = NSLocale.currentLocale()
            formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            
            //formatter.locale = NSLocale(localeIdentifier: NSLocaleIdentifier)
            tipLabel.text = formatter.stringFromNumber(tip) // $123"
            totalLabel.text = formatter.stringFromNumber(total)
            
        }
        
        
        
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

