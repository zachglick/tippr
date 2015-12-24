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
        settingsTipControl.selectedSegmentIndex = index
        tipStepper.value = percents[index]
        
        for i in 0...2 {
            settingsTipControl.setTitle(stringTip(percents[i]), forSegmentAtIndex: i)
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        
       // var initStr: String = settingsTipControl.titleForSegmentAtIndex(settingsTipControl.selectedSegmentIndex)!
        //var initDouble = doubleTip(initStr)
        
        var newStr = stringTip(tipStepper.value)
        settingsTipControl.setTitle(newStr, forSegmentAtIndex: settingsTipControl.selectedSegmentIndex)
        percents[settingsTipControl.selectedSegmentIndex] = tipStepper.value
        
    }
   
    @IBAction func onSelectionChanged(sender: AnyObject) {
        var initStr: String = settingsTipControl.titleForSegmentAtIndex(settingsTipControl.selectedSegmentIndex)!
        
        var tipDouble = doubleTip(initStr)
        tipStepper.value = tipDouble
        index = settingsTipControl.selectedSegmentIndex


    }

    @IBAction func onTouchUpInside(sender: AnyObject) {
        percents = [18.0, 20.0, 25.0]
        index = 1
        curr = true
        settingsTipControl.setTitle("18%", forSegmentAtIndex: 0)
        settingsTipControl.setTitle("20%", forSegmentAtIndex: 1)
        settingsTipControl.setTitle("25%", forSegmentAtIndex: 2)
        settingsTipControl.selectedSegmentIndex = 1
        tipStepper.value = 20.0
        
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
        var intStr: String = stringTip.substringToIndex(stringTip.endIndex.advancedBy(-1))
        return NSString(string: intStr).doubleValue
    }
    func stringTip(doubleTip: Double) -> String {
        return String(format:"%.0f",doubleTip) + "%"
    }
}
