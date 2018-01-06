//
//  EditTask.swift
//  Final
//
//  Created by Marcus Williams on 11/17/17.
//  Copyright © 2017 Marcus Williams. All rights reserved.
//

import UIKit

class EditTask: UIViewController {
    var classIndex:Int = 0
    var taskIndex:Int = 0
    var compsArr:[String] = []
    var className:String = ""
    
    @IBOutlet weak var ClassNameLabel: UILabel!
    @IBOutlet weak var taskNameBox: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var detail1Box: UITextField!
    @IBOutlet weak var detail2Box: UITextField!
    @IBOutlet weak var detail3Box: UITextField!
    @IBOutlet weak var paragraphBox: UITextView!
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        myTask.delete(index: taskIndex, classNum: classIndex)
        var comps = myTask.taskArray[classIndex].taskComponents! +  "*$*"
        if(taskNameBox.text! == ""){ comps += "empty" + "|$|" }
        else{
            comps += taskNameBox.text! + "|$|"
        }
        let date = dateFormatter.string(from: datePicker.date)
        comps += date + "|$|"
        if(detail1Box.text! == "")
        {
            comps += "empty" + "|$|"
        }
        else{
            comps += detail1Box.text! + "|$|"
        }
        if(detail2Box.text! == "")
        {
            comps += "empty" + "|$|"
        }
        else{
            comps += detail2Box.text! + "|$|"
        }
        if(detail3Box.text! == "")
        {
            comps += "empty" + "|$|"
        }
        else{
            comps += detail3Box.text! + "|$|"
        }
        comps += paragraphBox.text + "|$|"
        myTask.editAll(newComp:comps, taskNum: classIndex)
        NotificationCenter.default.post(name: Notification.Name(rawValue: mySpecialNotificationKey), object: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ClassNameLabel.text = className
        taskNameBox.text = compsArr[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let date = dateFormatter.date(from: compsArr[1])
        datePicker.setDate(date!, animated: true)
        detail1Box.text = compsArr[2]
        detail2Box.text = compsArr[3]
        detail3Box.text = compsArr[4]
        paragraphBox.text = compsArr[5]
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
