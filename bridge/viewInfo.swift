//
//  info.swift
//  bridge
//
//  Created by 钟镇阳 on 6/4/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class viewInfo: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var Name: UITextField!
    
    @IBOutlet var Email: UITextField!
    
    @IBOutlet var Birth: UITextField!
    
    @IBOutlet var Pass: UITextField!
    
    @IBOutlet var Repass: UITextField!
    
    @IBOutlet var image: UIImageView!
    
    let imagePickerController = UIImagePickerController()
    
    @IBAction func choose(sender: AnyObject) {
        
        imagePickerController.allowsEditing = false
        
        imagePickerController.sourceType = .PhotoLibrary
        
        presentViewController(imagePickerController, animated: true) { () -> Void in}
        
    }
    
    func alertView(View: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        switch buttonIndex{
            
        case 0:
            return
        case 1:
            var p = View.textFieldAtIndex(0)?.text
            if user.pass(hash_fun(p!)){
                var path = saveImage(image.image!)
                var word:Int
                if Pass.text.isEmpty{
                    word = -1
                }
                else {
                    word = hash_fun(Pass.text)
                }
                user.setInfo(Name.text, e: Email.text, b: Birth.text.toInt()!, p: word, i: path)
                data[Name.text]=user
                UIAlertView(title: "Saved", message: "Data have been successfully saved!", delegate: nil, cancelButtonTitle: "OK").show()
                
                self.dismissViewControllerAnimated(true, completion: { () -> Void in})
                saveData()
                main.setInfo(user.name(),path : user.getImage())
            }
            else {
                UIAlertView(title: "Error", message: "Incorrect password", delegate: nil, cancelButtonTitle: "OK").show()
            }
            return
        default:
            return
        }
    }
    
    @IBAction func save(sender: AnyObject) {

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
        if (Pass.text.isEmpty){
            let alert = UIAlertView(title: "Verify", message: "Please type your original password", delegate: nil, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
            alert.delegate = self
            
            alert.alertViewStyle = UIAlertViewStyle.SecureTextInput
            
            alert.show()
            return
            
        }
        
        if (count(Pass.text)<4 || count(Pass.text)>8){
            UIAlertView(title: "Warning", message: "A valid password should contain 4~8 characters", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        if Pass.text != Repass.text {
            UIAlertView(title: "Warning", message: "Passwords are not the same", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        
        
        let alert = UIAlertView(title: "Verify", message: "Please type your original password", delegate: nil, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
        alert.delegate = self
        
        alert.alertViewStyle = UIAlertViewStyle.SecureTextInput
        
        alert.show()
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
    }
    
    
    func saveImage(selectedImage:UIImage)->String{
        let fileManager = NSFileManager.defaultManager()
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var filePathToWrite = "\(paths)/SaveFile.jpg"
        var imageData: NSData = UIImagePNGRepresentation(selectedImage)
        fileManager.createFileAtPath(filePathToWrite, contents: imageData, attributes: nil)
        return filePathToWrite
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.contentMode = .ScaleAspectFit
            image.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var user:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        Name.text = user.name()
        Email.text = user.email()
        Birth.text = toString(user.birth())
        Pass.text = ""
        Repass.text = ""
        image.image = UIImage(contentsOfFile: user.getImage())
        imagePickerController.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
