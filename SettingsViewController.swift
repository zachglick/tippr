//
//  SettingsViewController.swift
//  tippr
//
//  Created by Zach Glick on 12/21/15.
//  Copyright © 2015 Zach Glick. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {

    @IBOutlet weak var currencySwitch: UISwitch!
    
    @IBOutlet weak var tipStepper:
        UIStepper!
   
    @IBOutlet weak var settingsTipControl: UISegmentedControl!
    
    @IBOutlet weak var defaultButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        let index = defaults.integerForKey("index")
        for i in 0...2 {
            settingsTipControl.setTitle(stringTip(defaults.doubleForKey("tip\(i)")), forSegmentAtIndex: i)
        }
        tipStepper.value = defaults.doubleForKey("tip\(index)")
        settingsTipControl.selectedSegmentIndex = index
        currencySwitch.on = defaults.boolForKey("curr")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        
        
        let newStr = stringTip(tipStepper.value)
        settingsTipControl.setTitle(newStr, forSegmentAtIndex: settingsTipControl.selectedSegmentIndex)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(tipStepper.value, forKey: "tip\(settingsTipControl.selectedSegmentIndex)")
        defaults.synchronize()
        
    }
   
    @IBAction func onSelectionChanged(sender: AnyObject) {
        let initStr: String = settingsTipControl.titleForSegmentAtIndex(settingsTipControl.selectedSegmentIndex)!
        
        let tipDouble = doubleTip(initStr)
        tipStepper.value = tipDouble
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(settingsTipControl.selectedSegmentIndex, forKey: "index")
        defaults.synchronize()

    }

    @IBAction func onTouchUpInside(sender: AnyObject) {
        settingsTipControl.setTitle("18%", forSegmentAtIndex: 0)
        settingsTipControl.setTitle("20%", forSegmentAtIndex: 1)
        settingsTipControl.setTitle("25%", forSegmentAtIndex: 2)
        settingsTipControl.selectedSegmentIndex = 1
        tipStepper.value = 20.0
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(18.0, forKey: "tip0")
        defaults.setDouble(20.0, forKey: "tip1")
        defaults.setDouble(25.0, forKey: "tip2")
        defaults.setInteger(1, forKey: "index")
        defaults.setBool(true, forKey: "curr")
        currencySwitch.setOn(true, animated: true)
        defaults.synchronize()

        
    }

    @IBAction func onCurrChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(currencySwitch.on, forKey: "curr")
        defaults.synchronize()        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func doubleTip(stringTip: String) -> Double{
        let intStr: String = stringTip.substringToIndex(stringTip.endIndex.advancedBy(-1))
        return NSString(string: intStr).doubleValue
    }
    func stringTip(doubleTip: Double) -> String {
        return String(format:"%.0f",doubleTip) + "%"
    }
}
