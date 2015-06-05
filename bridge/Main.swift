//
//  Main.swift
//  bridge
//
//  Created by 钟镇阳 on 6/3/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class Main: UIViewController {
    
    var user:User!
    @IBOutlet var welcome: UILabel!
    
    @IBOutlet var image: UIImageView!
    
    @IBAction func Info(sender: AnyObject) {
        var vc = viewInfo(nibName:"viewInfo",bundle:nil)
        vc.user = self.user
        //println(vc.user.name())
        self.presentViewController(vc, animated: true) { () -> Void in}
    }

    @IBAction func teacher(sender: AnyObject) {
    }
    
    @IBAction func student(sender: AnyObject) {
        
        var oneStoryBoard:UIStoryboard = UIStoryboard(name: "Course", bundle: NSBundle.mainBundle())
        let vc:UIViewController = oneStoryBoard.instantiateViewControllerWithIdentifier("table") as! UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    @IBAction func out(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
    }
    
    @IBAction func calender(sender: AnyObject) {
    }
    
    func setInfo(name:String, path:String){
        welcome.text = "Welcome \(user.name())"
        image.image = UIImage(contentsOfFile: user.getImage())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcome.text = "Welcome \(user.name())"
        image.image = UIImage(contentsOfFile: user.getImage())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
