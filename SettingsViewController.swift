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
        tipStepper.value = 50
        var initVal: String = settingsTipControl.titleForSegmentAtIndex(settingsTipControl.selectedSegmentIndex)!
        var initVal2: String = initVal.substringToIndex(initVal.endIndex.advancedBy(-1))
        var initDouble = NSString(string: initVal2).doubleValue

        print("initial \(initVal) final \(initVal2) double \(initDouble)")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        
        var initVal: String = settingsTipControl.titleForSegmentAtIndex(settingsTipControl.selectedSegmentIndex)!
        var initVal2: String = initVal.substringToIndex(initVal.endIndex.advancedBy(-1))
        
        var initDouble = NSString(string: initVal2).doubleValue
        
        initDouble += 1.0
        
        var finalStr = String(format:"%.0f",initDouble) + "%"
        settingsTipControl.setTitle(finalStr, forSegmentAtIndex: settingsTipControl.selectedSegmentIndex)
        print(finalStr)
    }
   
    @IBAction func onSelectionChanged(sender: AnyObject) {
        var initStr: String = settingsTipControl.titleForSegmentAtIndex(settingsTipControl.selectedSegmentIndex)!
        var intStr: String = initStr.substringToIndex(initStr.endIndex.advancedBy(-1))
        var tipDouble = NSString(string: intStr).doubleValue
        tipStepper.value = tipDouble
        
        print("Stepper Value now \(tipDouble)")


    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
