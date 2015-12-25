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
        print("View Did Load")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refresh", name: UIApplicationDidBecomeActiveNotification, object: nil)
        super.title = "tippr"
        let defaults = NSUserDefaults.standardUserDefaults()

        
        if(defaults.objectForKey("tip0") == nil){
            defaults.setDouble(18.0, forKey: "tip0")
            defaults.setDouble(20.0, forKey: "tip1")
            defaults.setDouble(25.0, forKey: "tip2")
        }
        if(defaults.objectForKey("index") == nil){
            defaults.setInteger(1, forKey: "index")
        }
        tipControl.selectedSegmentIndex = defaults.integerForKey("index")
        if(defaults.objectForKey("curr") == nil){
            defaults.setBool(true, forKey: "curr")
        }
        if(defaults.objectForKey("bill") == nil || defaults.doubleForKey("bill") == 0.0){
            defaults.setDouble(0.0, forKey: "bill")
            tipLabel.text = "$0.00"
            totalLabel.text = "$0.00"
        }
        else{
            billField.text = String(format: "%g", defaults.doubleForKey("bill"))
        }
        defaults.synchronize()
        billField.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        print("View Will Appear")
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if(defaults.objectForKey("oldDate") != nil){
            let interval = NSDate().timeIntervalSinceDate(defaults.objectForKey("oldDate") as! NSDate!)
            if(interval > 600.0){
                defaults.setDouble(0.0, forKey: "bill")
                tipLabel.text = "$0.00"
                totalLabel.text = "$0.00"
                billField.text = ""
            }
            
        }
        
        
        for i in 0...2 {
            tipControl.setTitle(stringTip(defaults.doubleForKey("tip\(i)")), forSegmentAtIndex: i)
        }
        tipControl.selectedSegmentIndex = defaults.integerForKey("index")
        
        onEditingChanged(billField)
        
    }


    @IBAction func onEditingChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentages = [defaults.doubleForKey("tip0")/100, defaults.doubleForKey("tip1")/100, defaults.doubleForKey("tip2")/100]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        defaults.setDouble(billAmount, forKey: "bill")
        
        let tip = billAmount * tipPercentage
        let total = tip + billAmount
        
        
        if(defaults.boolForKey("curr") == false){
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
        }
        else{
            let formatter = NSNumberFormatter()
            formatter.locale = NSLocale.currentLocale()
            formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            
            
            tipLabel.text = formatter.stringFromNumber(tip) // $123"
            totalLabel.text = formatter.stringFromNumber(total)
            
        }
        defaults.synchronize()
        
    }

    func refresh(){
        print("Refresh")
        onEditingChanged(self)
   
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func doubleTip(stringTip: String) -> Double{
        
        let intStr: String = stringTip.substringToIndex(stringTip.endIndex.advancedBy(-1))
        return NSString(string: intStr).doubleValue
    }
    
    func stringTip(doubleTip: Double) -> String {
        
        return String(format:"%.0f",doubleTip) + "%"
    }
}

