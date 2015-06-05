//
//  ViewController.swift
//  bridge
//
//  Created by 钟镇阳 on 6/1/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

func pow(x:Int,y:Int)->Int{
    var b = 1
    for i in 0..<y{
        b*=x
    }
    return b
}

func hash_fun(n:String)->Int{
    var k = count(n)
    var a = 0
    for b in 0..<k {
        var c = pow(128,k-b-1)
        a+=c
    }
    //var m = [0,0,0,0]
    var m = [Int]()
    for i in 0..<4{
        var q = a%65521
        m.append(q)
        a/=65521
    }
    var w = 45912 * m[0]
    w += 35511 * m[1]
    w += 65169 * m[2]
    w += 4625 * m[3]
    w %= 65521;
    return w
}

var currUser:User!

var main:Main!

func saveData(){
    var out = NSMutableDictionary()
    var size = data.count
    for i in 0..<size{
        var person = ["name":(data.allValues[i] as! User).name(),
            "email":(data.allValues[i] as! User).email(),
            "birth":(data.allValues[i] as! User).birth(),
            "pass":(data.allValues[i] as! User).passWord(),
            "image":(data.allValues[i] as! User).getImage()]
        out[person["name"] as! String] = person
    }
    out.writeToFile(path!, atomically: false)
    //let n = NSMutableDictionary(contentsOfFile: path!)
    //println(n)
}


var path = NSBundle.mainBundle().pathForResource("data", ofType: "plist")

func dataParser()->NSMutableDictionary{
    let data = NSDictionary(contentsOfFile: path!)
    var data1 = NSMutableDictionary()
    if let size = data?.count{
        for i in 0..<size{
            var info = data?.allValues[i] as! NSDictionary
            var name: AnyObject? = info["name"]
            var email: AnyObject? = info["email"]
            var birth: AnyObject? = info["birth"]
            var pass: AnyObject? = info["pass"]
            var image: AnyObject? = info["image"]
            var user = User(n: name as! String, e: email as! String, b: birth as! Int, p: pass as! Int, i: image as! String)
            data1[user.name()]=user
        }
    }
    return data1
}

var data = dataParser()

class ViewController: UIViewController {

    @IBOutlet var pass: UITextField!
    @IBOutlet var name: UITextField!
    @IBAction func login(sender: AnyObject) {
        if let info = data[name.text] as? User{
            if info.pass(hash_fun(pass.text)){
                
                var vc = Main(nibName:"Main",bundle:nil)
                vc.user = info as User
                main = vc
                self.presentViewController(vc, animated: true) { () -> Void in}
            }
            else {
                UIAlertView(title: "Fail", message: "Login Fail", delegate: nil, cancelButtonTitle: "OK").show()
            }
        }
        else {
            UIAlertView(title: "Warning", message: "No such a user could be found", delegate: nil, cancelButtonTitle: "OK").show()
        }
    }
    @IBAction func sign_up(sender: AnyObject) {
        let vc = signup(nibName:"signup",bundle:nil)
        self.presentViewController(vc, animated: true) { () -> Void in}
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

