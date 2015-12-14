//
//  BookSelectIC.swift
//  BibleBooks
//
//  Created by Alex Hinkle on 12/14/15.
//  Copyright © 2015 cuw. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class BookSelectIC: WKInterfaceController, WCSessionDelegate
{
    static var score = 0
    static var numberGuesses = 0

    @IBOutlet var theTable: WKInterfaceTable!
    var session : WCSession!
    
    
    let correctAlert = WKAlertAction(title: "correct", style: WKAlertActionStyle.Cancel, handler: { () -> Void in })
    let wrongAlert = WKAlertAction(title: "incorrect", style: WKAlertActionStyle.Cancel, handler: { () -> Void in })
    static var currSelectedIndex = -1
    
    
    
    
    override func awakeWithContext(context: AnyObject?)
    {
        if WCSession.isSupported() {
            self.session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
        
        //let prefs = NSUserDefaults.standardUserDefaults()

        
        super.awakeWithContext(context)
        
       
        
        
        self.theTable.setNumberOfRows(watchCore.bibleBooksArray.count, withRowType: "cell")
        for( var i = 0; i < watchCore.bibleBooksArray.count; i++)
        {
            let currRow = self.theTable.rowControllerAtIndex(i) as! bookRow
            currRow.theLabel.setText(watchCore.bibleBooksArray[i])
           
            
        }
        
        
    }
    func generateTable()
    {
        self.theTable.setNumberOfRows(watchCore.bibleBooksArray.count, withRowType: "cell")
        
        for(var i = 0; i < watchCore.bibleBooksArray.count; i++)
        {
        }
    }


    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int)
    {
        print(rowIndex)
        var bookPosition = 0
        print(bookPosition)
        
        
       
    
           BookSelectIC.currSelectedIndex = rowIndex
            
            
            if(watchCore.bibleBooksArray[rowIndex] == watchCore.bibleBooksArray[bookPosition])
            {
            print("correct")
            self.presentAlertControllerWithTitle("correct", message: "correct", preferredStyle: WKAlertControllerStyle.Alert, actions: [correctAlert])
                watchCore.bibleBooksArray.removeAtIndex(bookPosition)
                BookSelectIC.score = BookSelectIC.score + 1
                BookSelectIC.numberGuesses = BookSelectIC.numberGuesses + 1
                bookPosition++
    
                
                
            
            
            
            }
            else if(watchCore.bibleBooksArray[rowIndex] != watchCore.bibleBooksArray[bookPosition])
            {
                print("Wrong")
            self.presentAlertControllerWithTitle("incorrect", message: "Incorrect", preferredStyle: WKAlertControllerStyle.Alert, actions: [wrongAlert])
                BookSelectIC.numberGuesses = BookSelectIC.numberGuesses + 1
                
            }
        else if(bookPosition == watchCore.bibleBooksArray.count)
            {
                sendScore(BookSelectIC.score)
        }
            
            
        
        }
    func sendScore(score: Int)
    {
        let applicationDict = ["score":score]
        do {
            try session.updateApplicationContext(applicationDict)
        } catch {
            print("error")
        }
    }
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
