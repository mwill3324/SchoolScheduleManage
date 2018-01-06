//
//  ShowTask.swift
//  Final
//
//  Created by Marcus Williams on 11/17/17.
//  Copyright © 2017 Marcus Williams. All rights reserved.
//

import UIKit

class ShowTask: UIViewController {
    //View Parts
    
    @IBOutlet weak var ClassName: UILabel!
    @IBOutlet weak var TaskName: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var Detail1: UILabel!
    @IBOutlet weak var Detail2: UILabel!
    @IBOutlet weak var Detail3: UILabel!
    @IBOutlet weak var ParagraphBox: UITextView!
    ///////////moddel//////////
    var classTasks:[String] = []
    var taskComponents:[String] = []
    var taskComps:String?
    var cName:String?
    var compsArr:[String]?
    var ClassNumber:Int=0
    var TaskNumber:Int = 0
    /////////Controller////
    func splitArray()
    {
        compsArr = (taskComps?.components(separatedBy: "|$|"))
        compsArr = compsArr?.filter{$0 != ""}
    }
    
    func refresh()
    {
        myTask.load()
        classTasks = (myTask.taskArray[ClassNumber].taskComponents?.components(separatedBy: "*$*"))!
        classTasks = classTasks.filter{$0 != ""}
        let LastTNum:Int = classTasks.count
        taskComponents = (classTasks[LastTNum-1].components(separatedBy: "|$|"))
        taskComponents = taskComponents.filter{$0 != ""}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        splitArray()
        // Do any additional setup after loading the view.
        ClassName.text = cName
        TaskName.text = compsArr?[0]
        DateLabel.text = compsArr?[1]
        Detail1.text = compsArr?[2]
        Detail2.text = compsArr?[3]
        Detail3.text = compsArr?[4]
        ParagraphBox.text = compsArr?[5]
        NotificationCenter.default.addObserver(self, selector: #selector(ClassesViewController.actOnSpecialNotification), name: NSNotification.Name(rawValue: mySpecialNotificationKey), object: nil)
    }
    @objc func actOnSpecialNotification() {
        myTask.load()
        refresh()
        ClassName.text = cName
        TaskName.text = taskComponents[0]
        DateLabel.text = taskComponents[1]
        Detail1.text = taskComponents[2]
        Detail2.text = taskComponents[3]
        Detail3.text = taskComponents[4]
        ParagraphBox.text = taskComponents[5]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showEditTask"){
            if let editTask: EditTask = segue.destination as? EditTask {
                editTask.className = cName!
                editTask.compsArr = compsArr!
                editTask.classIndex = ClassNumber
            }
        }
    }
    
    
    
}
