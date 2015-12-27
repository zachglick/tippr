//
//  EtiquetteViewController.swift
//  tippr
//
//  Created by Zach Glick on 12/24/15.
//  Copyright © 2015 Zach Glick. All rights reserved.
//

import UIKit

class EtiquetteViewController: UIViewController {

    @IBOutlet weak var q1View: UIView!
    @IBOutlet weak var q2View: UIView!
    @IBOutlet weak var q3View: UIView!
    @IBOutlet weak var q4View: UIView!
    @IBOutlet weak var a1View: UIView!
    @IBOutlet weak var a2View: UIView!
    @IBOutlet weak var a3View: UIView!
    @IBOutlet weak var a4View: UIView!
    
    @IBOutlet weak var q1Label: UILabel!
    @IBOutlet weak var q2Label: UILabel!
    @IBOutlet weak var q3Label: UILabel!
    @IBOutlet weak var q4Label: UILabel!
    @IBOutlet weak var a1Label: UILabel!
    @IBOutlet weak var a2Label: UILabel!
    @IBOutlet weak var a3Label: UILabel!
    @IBOutlet weak var a4Label: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Etiquette"
        refreshView()
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(0, forKey: "q")
        defaults.synchronize()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func on0Tap(sender: AnyObject) {
        print("onTap0")
        close()

    }
    @IBAction func on1Tap(sender: AnyObject) {
        print("onTap1")
        let defaults = NSUserDefaults.standardUserDefaults()
        let q = defaults.integerForKey("q")
        if(q != 1){
            defaults.setInteger(1, forKey: "q")
            UIView.animateWithDuration(0.75, animations:{
                self.q1View.center.y = 155
                self.q2View.center.y = 315
                self.q3View.center.y = 395
                self.q4View.center.y = 475
                self.q1View.center.x = 160
                self.q2View.center.x = 145
                self.q3View.center.x = 145
                self.q4View.center.x = 145
                self.a1View.alpha = 1
                self.a2View.alpha = 0
                self.a3View.alpha = 0
                self.a4View.alpha = 0

            })}
        else{
            close()
        }
    }
    @IBAction func on2Tap(sender: AnyObject) {
        print("onTap2")
        let defaults = NSUserDefaults.standardUserDefaults()
        let q = defaults.integerForKey("q")
        if(q != 2){
            defaults.setInteger(2, forKey: "q")

        UIView.animateWithDuration(0.75, animations:{
            self.q1View.center.y = 155
            self.q2View.center.y = 235
            self.q3View.center.y = 395
            self.q4View.center.y = 475
            self.q1View.center.x = 145
            self.q2View.center.x = 160
            self.q3View.center.x = 145
            self.q4View.center.x = 145
            self.a1View.alpha = 0
            self.a2View.alpha = 1
            self.a3View.alpha = 0
            self.a4View.alpha = 0
        })}
        else{
            close()
        }
    }
    @IBAction func on3Tap(sender: AnyObject) {
        print("onTap3")
        let defaults = NSUserDefaults.standardUserDefaults()
        let q = defaults.integerForKey("q")
        if(q != 3){
            defaults.setInteger(3, forKey: "q")

        UIView.animateWithDuration(0.75, animations:{
            self.q1View.center.y = 155
            self.q2View.center.y = 235
            self.q3View.center.y = 315
            self.q4View.center.y = 475
            self.q1View.center.x = 145
            self.q2View.center.x = 145
            self.q3View.center.x = 160
            self.q4View.center.x = 145
            self.a1View.alpha = 0
            self.a2View.alpha = 0
            self.a3View.alpha = 1
            self.a4View.alpha = 0
        })}
        else{
            close()
        }
    }
    @IBAction func on4Tap(sender: AnyObject) {
        print("onTap4")
        let defaults = NSUserDefaults.standardUserDefaults()
        let q = defaults.integerForKey("q")
        if(q != 4){
            defaults.setInteger(4, forKey: "q")

        UIView.animateWithDuration(1.0, animations:{
            self.q1View.center.y = 155
            self.q2View.center.y = 235
            self.q3View.center.y = 315
            self.q4View.center.y = 395
            self.q1View.center.x = 145
            self.q2View.center.x = 145
            self.q3View.center.x = 145
            self.q4View.center.x = 160
            self.a1View.alpha = 0
            self.a2View.alpha = 0
            self.a3View.alpha = 0
            self.a4View.alpha = 1
        })}
        else{
            close()
        }
        
    }
    
    func close(){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(0, forKey: "q")
        defaults.synchronize()
        UIView.animateWithDuration(1.0, animations:{
            self.q1View.center.y = 155
            self.q2View.center.y = 235
            self.q3View.center.y = 315
            self.q4View.center.y = 395
            self.q1View.center.x = 145
            self.q2View.center.x = 145
            self.q3View.center.x = 145
            self.q4View.center.x = 145
            self.a1View.alpha = 0
            self.a2View.alpha = 0
            self.a3View.alpha = 0
            self.a4View.alpha = 0
            

        })
    }
    func refreshView(){
        
            print("View Refreshed!")
            let defaults = NSUserDefaults.standardUserDefaults()
            let darkColor = UIColor(red: 89/255.0, green: 119/255.0, blue: 89/255, alpha: 1.0)
            let lightColor = UIColor(red: 189/255.0, green: 216/255.0, blue: 189/255, alpha: 1.0)
            
            if(defaults.boolForKey("defLight") == true){
                self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
                self.view.backgroundColor = lightColor
                self.navigationController?.navigationBar.tintColor = darkColor
                q1View.backgroundColor = darkColor
                q2View.backgroundColor = darkColor
                q3View.backgroundColor = darkColor
                q4View.backgroundColor = darkColor
                //a1View.backgroundColor = lightColor
                //a2View.backgroundColor = lightColor
                //a3View.backgroundColor = lightColor
                //a4View.backgroundColor = lightColor
                
                
                a1Label.textColor = darkColor
                a2Label.textColor = darkColor
                a3Label.textColor = darkColor
                a4Label.textColor = darkColor
                q1Label.textColor = lightColor
                q2Label.textColor = lightColor
                q3Label.textColor = lightColor
                q4Label.textColor = lightColor


                
            }
            else{
                self.navigationController?.navigationBar.barTintColor = UIColor.grayColor()
                self.view.backgroundColor = darkColor
                self.navigationController?.navigationBar.tintColor = lightColor
                //a1View.backgroundColor = darkColor
                //a2View.backgroundColor = darkColor
                //a3View.backgroundColor = darkColor
                //a4View.backgroundColor = darkColor
                q1View.backgroundColor = lightColor
                q2View.backgroundColor = lightColor
                q3View.backgroundColor = lightColor
                q4View.backgroundColor = lightColor
                
                
                q1Label.textColor = darkColor
                q2Label.textColor = darkColor
                q3Label.textColor = darkColor
                q4Label.textColor = darkColor
                a1Label.textColor = lightColor
                a2Label.textColor = lightColor
                a3Label.textColor = lightColor
                a4Label.textColor = lightColor
            }
        
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
