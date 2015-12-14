//
//  UserHomepageVC.swift
//  DiceRoller
//
//  Created by Alex Hinkle on 11/23/15.
//  Copyright © 2015 Alex Hinkle. All rights reserved.
//

import UIKit
import WatchConnectivity
import Parse

class UserHomepageVC: UIViewController, WCSessionDelegate, UITableViewDelegate
{    @IBOutlet weak var theTableView: UITableView!
    var session : WCSession!
    var mainScore = ""
      
    
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        let score = applicationContext["score"] as? String
        mainScore = score!
        
        
        //Use this to update the UI instantaneously (otherwise, takes a little while)
        dispatch_async(dispatch_get_main_queue()) {
            
        }
    }
    
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if WCSession.isSupported()
        {
            self.session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
        //get the current rolls associated with this user
        let query = PFQuery(className:"score")
        query.whereKey("owner_id", equalTo: PhoneCore.currentUser)
        query.findObjectsInBackgroundWithBlock { (objects : [PFObject]?, error: NSError?) -> Void in
            if(objects != nil)
            {
                PhoneCore.theRowData = objects!
                self.theTableView.reloadData()
                print("found")
                print(PhoneCore.theRowData)
            }
            else
            {
                print("None Found")
            }
        }
        let obj = PFObject(className: "score")
        obj.setValue(mainScore, forKey: "score")
        
        obj.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
            if(success)
            {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else
            {
                PhoneCore.showAlert("Message Create Error", message: "Something went wrong during save!!!!", presentingViewController: self, onScreenDelay: 2.0)
            }
            
            
            
        })

        
        
    }
    
  
       
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PhoneCore.theRowData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        // Configure the cell...
        
        //update this code to fill the labels with the proper values
        let score = PhoneCore.theRowData[indexPath.row].valueForKey("score")!
        
        
        cell.scoreLabel.text = score as? String
        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
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