//
//  signup.swift
//  bridge
//
//  Created by 钟镇阳 on 6/1/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

func isValidEmail(testStr:String) -> Bool {
    // println("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluateWithObject(testStr)
}

class signup: UIViewController {
    @IBOutlet var Name: UITextField!

    @IBOutlet var Email: UITextField!
    
    @IBOutlet var Birth: UITextField!
    
    @IBOutlet var Pass: UITextField!
    
    @IBAction func signup(sender: AnyObject) {
        let name : String = Name.text
        if (count(name)<4 || count(name)>13){
            UIAlertView(title: "Warning", message: "User name's length should be between 5~12", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        if !isValidEmail(Email.text){
            UIAlertView(title: "Warning", message: "Email address is not valid", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        var year_ : Int
        if let year = Birth.text.toInt(){
            if (year<1900 || year>2015){
                UIAlertView(title: "Warning", message: "Your birth year is not valid, a valid birth year should be between 1900~2015", delegate: nil, cancelButtonTitle: "OK").show()
                return
            }
            year_ = year
        }
        else {
            UIAlertView(title: "Warning", message: "Birth should be integer, your birth year", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        if (count(Pass.text)<4 || count(Pass.text)>8){
            UIAlertView(title: "Warning", message: "A valid password should contain 4~8 characters", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        currUser=User(n: Name.text, e: Email.text, b: Birth.text.toInt()!, p: hash_fun(Pass.text))
        data[Name.text]=currUser
        saveData()
        
        var vc = Main(nibName:"Main",bundle:nil)
        vc.user = currUser
        main = vc
        self.presentViewController(vc, animated: true) { () -> Void in}
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
