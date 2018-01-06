//
//  AddTask.swift
//  Final
//
//  Created by Marcus Williams on 11/16/17.
//  Copyright © 2017 Marcus Williams. All rights reserved.
//

import UIKit

class AddTask: UIViewController {
   
    var className:String?
    var classNum:Int = 0
    
    @IBOutlet var classNameLabel: UILabel!
    @IBOutlet var DateSelector: UIDatePicker!
    @IBOutlet var TaskName: UITextField!
    @IBOutlet var TaskDetail1: UITextField!
    @IBOutlet var TaskDetail2: UITextField!
    @IBOutlet var TaskDetail3: UITextField!
    @IBOutlet var TaskDescription: UITextView!
    
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        myTask.load()
        classNameLabel.text = className
        dateFormatter.dateFormat = "MM-dd-yyyy"
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func SaveIt(_ sender: Any) {
        //*$* seperates tasks
        //|$| seperates task components
        saveButton.isEnabled = false
        print("SAVED")
       // print(myTask.taskArray[classNum].taskComponents!)
        var comps = myTask.taskArray[classNum].taskComponents! +  "*$*"
        if(TaskName.text! == "")
        {
            comps += "empty" + "|$|"
        }
        else{
            comps += TaskName.text! + "|$|"
        }
        let date = dateFormatter.string(from: DateSelector.date)
        comps += date + "|$|"
        if(TaskDetail1.text! == "")
        {
          comps += "empty" + "|$|"
        }
        else{
            comps += TaskDetail1.text! + "|$|"
        }
        if(TaskDetail2.text! == "")
        {
            comps += "empty" + "|$|"
        }
        else{
            comps += TaskDetail2.text! + "|$|"
        }
        if(TaskDetail3.text! == "")
        {
            comps += "empty" + "|$|"
        }
        else{
            comps += TaskDetail3.text! + "|$|"
        }
        comps += TaskDescription.text + "|$|"
        print("test")
        print(comps)
        myTask.editAll(newComp:comps, taskNum: classNum)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: mySpecialNotificationKey), object: self)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
