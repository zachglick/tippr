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
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var AnimatedView2: UIView!
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var tipMarkerLabel: UILabel!
    @IBOutlet weak var totalMarkerLabel: UILabel!
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var counterStepper: UIStepper!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var counterLabel2: UILabel!
    
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
        if(defaults.objectForKey("defLight") == nil){
            defaults.setBool(true, forKey: "defLight")
        }
        
        defaults.setInteger(1, forKey: "counter")
        
        defaults.synchronize()
        
        
        
        billField.becomeFirstResponder()
        
        let currsym = NSLocale.currentLocale().objectForKey(NSLocaleCurrencySymbol) as? String
        if(defaults.boolForKey("curr") == true){
            billField.placeholder = currsym
        }
        else{
            billField.placeholder = "$"
            
        }
        defaults.synchronize()
        

        makeCounterLabel()
        
        refreshView()
        
        
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
                print("TIME OUT")
                defaults.setDouble(0.0, forKey: "bill")
                defaults.setInteger(1, forKey: "counter")
                defaults.setBool(true, forKey: "defLight")
                defaults.setBool(true, forKey: "curr")
                defaults.setInteger(1, forKey: "index")
                defaults.synchronize()
                tipLabel.text = "$0.00"
                totalLabel.text = "$0.00"
                billField.text = ""
            }
            print("interval \(interval/60.0) minutes")
            
        }
        
        
        for i in 0...2 {
            tipControl.setTitle(stringTip(defaults.doubleForKey("tip\(i)")), forSegmentAtIndex: i)
        }
        tipControl.selectedSegmentIndex = defaults.integerForKey("index")
        let currsym = NSLocale.currentLocale().objectForKey(NSLocaleCurrencySymbol) as? String
        if(defaults.boolForKey("curr") == true){
            billField.placeholder = currsym
        }
        else{
            billField.placeholder = "$"

        }
        defaults.synchronize()
        refreshView()
        makeCounterLabel()
        onEditingChanged(billField)
        
    }


    @IBAction func onEditingChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey:"oldDate")
        defaults.synchronize()
        
        var tipPercentages = [defaults.doubleForKey("tip0")/100, defaults.doubleForKey("tip1")/100, defaults.doubleForKey("tip2")/100]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        //self.firstView.alpha = 0
        if(billField.text != ""){
            UIView.animateWithDuration(1.0, animations:{
                    self.animatedView.center.y = 425
                    self.AnimatedView2.center.y = 125
                    self.counterView.center.x = 57
                if(defaults.integerForKey("counter") > 1){
                    print("trueue \(defaults.integerForKey("counter"))"  )
                    self.counterLabel2.center.x = 260
                }
            })
        }
        if(billField.text == ""){
            UIView.animateWithDuration(1.0, animations:{
                self.animatedView.center.y = 700
                self.AnimatedView2.center.y = 214
                self.counterView.center.x = -57

            })

        }
        if(defaults.integerForKey("counter") == 1 && billField.text != ""){
            UIView.animateWithDuration(1.0, animations:{
            self.counterLabel2.center.x = 360
            })

        }
        
        let billAmount = NSString(string: billField.text!).doubleValue
        defaults.setDouble(billAmount, forKey: "bill")
        
        let tip = billAmount * tipPercentage / Double(defaults.integerForKey("counter"))
        let total = tip + billAmount / Double(defaults.integerForKey("counter"))
        
        
        if(defaults.boolForKey("curr") == false){
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
        }
        else{
            let formatter = NSNumberFormatter()
            formatter.locale = NSLocale.currentLocale()
            formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            
            tipLabel.text = formatter.stringFromNumber(tip)
            totalLabel.text = formatter.stringFromNumber(total)
            
        }

        
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
    
    func refreshView() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let darkColor = UIColor(red: 89/255.0, green: 119/255.0, blue: 89/255, alpha: 1.0)
        let lightColor = UIColor(red: 189/255.0, green: 216/255.0, blue: 189/255, alpha: 1.0)
        if(defaults.boolForKey("defLight") == true){
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            billField.keyboardAppearance = .Light
            darkView.backgroundColor = darkColor
            tipControl.tintColor = darkColor
            
            self.navigationItem.leftBarButtonItem?.tintColor = darkColor
            self.navigationItem.rightBarButtonItem?.tintColor = darkColor
            billField.textColor = darkColor
            
            self.view.backgroundColor = lightColor
            AnimatedView2.backgroundColor = lightColor
            
            totalLabel.textColor = UIColor.whiteColor()
            tipLabel.textColor = UIColor.whiteColor()
            totalMarkerLabel.textColor = UIColor.whiteColor()
            tipMarkerLabel.textColor = UIColor.whiteColor()
            counterStepper.tintColor = darkColor
            counterLabel.textColor = darkColor
            counterLabel2.textColor = lightColor

            billField.tintColor = darkColor
            
            counterLabel2.shadowColor = lightColor
            counterLabel2.shadowOffset = CGSize(width: -1, height: -1)
            counterLabel.shadowOffset = CGSize(width: 0, height: 0)
            
            

            
        }
        else{
            self.navigationController?.navigationBar.barTintColor = UIColor.grayColor()
            billField.keyboardAppearance = .Dark
            darkView.backgroundColor = lightColor
            tipControl.tintColor = lightColor
            
            self.navigationItem.leftBarButtonItem?.tintColor = lightColor
            self.navigationItem.rightBarButtonItem?.tintColor = lightColor
            billField.textColor = lightColor
            
            self.view.backgroundColor = darkColor
            AnimatedView2.backgroundColor = darkColor
            
            totalLabel.textColor = UIColor.grayColor()
            tipLabel.textColor = UIColor.grayColor()
            totalMarkerLabel.textColor = UIColor.grayColor()
            tipMarkerLabel.textColor = UIColor.grayColor()
            counterStepper.tintColor = lightColor
            counterLabel.textColor = lightColor
            counterLabel2.textColor = darkColor

            billField.tintColor = lightColor
            
            
            counterLabel.shadowColor = lightColor
            counterLabel.shadowOffset = CGSize(width: -1, height: -1)
            counterLabel2.shadowOffset = CGSize(width: 0, height: 0)
    
            
            
        }

    
    }
    
    func makeCounterLabel() {
        let defaults = NSUserDefaults.standardUserDefaults()
        counterLabel.text = ""
        let count = defaults.integerForKey("counter")
        if(count < 5){
            for i in 1...count{
                counterLabel.text?.appendContentsOf("👤")
            }
        }
        else{
            counterLabel.text = "\(count) 👤"
        }
        counterLabel2.text = counterLabel.text
    }
    @IBAction func onCounterChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(Int(round(counterStepper.value)), forKey: "counter")
        makeCounterLabel()

    }
}

