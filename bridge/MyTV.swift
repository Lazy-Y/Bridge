//
//  MyTV.swift
//  L02
//
//  Created by 钟镇阳 on 5/31/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class MyTV: UITableView, UITableViewDelegate, UITableViewDataSource{
    /*init(coder aDecoder:NSCoder!){
    super.init(coder:aDecoder)
    self.dataSourc = self
    }*/
    let TAG_CELL_LABEL=1
    
    var data = NSDictionary(contentsOfURL: NSBundle.mainBundle().URLForResource("course", withExtension: "plist")!)
    //var data = NSDictionary(contentsOfFile: "data.plist")
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //data = NSDictionary(contentsOfFile: "data.plist")!
        self.dataSource=self
        self.delegate=self
    }
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var arr = data?.allValues[section] as! NSArray
        var num = arr.count
        return num
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data!.allKeys[section] as? String
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        var label = cell.viewWithTag(TAG_CELL_LABEL) as! UILabel
        //label.text = dataArr[indexPath.row]
        label.text = (data?.allValues[indexPath.section] as! NSArray)[indexPath.row] as? String
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data!.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        println("hello")
        println("\((data?.allValues[indexPath.section] as! NSArray).objectAtIndex(indexPath.row)) Clicked")
    }
    
}
