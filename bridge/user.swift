//
//  user.swift
//  bridge
//
//  Created by 钟镇阳 on 6/1/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import Foundation

class User: NSObject {
    private var name_:String = ""
    private var birth_:Int = -1
    private var pass_:Int = -1
    private var email_:String = ""
    private var image_:String = "/Users/ZhenyangZhong/cs/bridge/bridge/20130804012655_EUAKW.thumb.700_0.jpeg"
    init(n:String,e:String,b:Int,p:Int){
        name_=n
        email_=e
        birth_=b
        pass_=p
    }
    init(n:String,e:String,b:Int,p:Int,i:String){
        name_=n
        email_=e
        birth_=b
        pass_=p
        image_=i
    }
    func setInfo(n:String,e:String,b:Int,p:Int,i:String){
        name_=n
        email_=e
        birth_=b
        if p != -1 {
            pass_ = p
        }
        image_=i
    }
    func name()->String{
        return name_
    }
    func email()->String{
        return email_
    }
    func birth()->Int{
        return birth_
    }
    func passWord()->Int{
        return pass_
    }
    func pass(n:Int)->Bool{
        if n == pass_ {
            return true
        }
        else {
            return false
        }
    }
    func getInfo()->(String,String,Int){
        return (name_,email_,birth_)
    }
    func getImage()->String{
        return image_
    }
}

