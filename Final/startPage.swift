//
//  startPage.swift
//  homework2
//
//  Created by Marcus Williams on 11/8/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
var myPlace : place = place()
var myTask : task = task()

let mySpecialNotificationKey = "justdoit"
let EditNotificationKey = "justdoit"

class startPage: UIViewController, UITableViewDataSource , UITableViewDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    /////view
    @IBOutlet var TimeLabel: UILabel!
    @IBOutlet var DateLabel: UILabel!
    @IBOutlet var ClassTable: UITableView!
    @IBOutlet var TaskTable: UITableView!
    /////////////Model
    var timer = Timer()
    var todaysTasks:[String] = []
    var todaysTcomps:[[String]] = [[]]
    var classTasks:[String] = []
    var taskComponents:[[String]] = [[]]
    ////////////Controller//////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Starts notification Observer
        NotificationCenter.default.addObserver(self, selector: #selector(startPage.actOnSpecialNotification), name: NSNotification.Name(rawValue: mySpecialNotificationKey), object: nil)
        ///
        myPlace.load()
        myTask.load()
        updateDailyTasks()
        
        TaskTable.reloadData()
        ClassTable.reloadData()
        
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        TimeLabel.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .none, timeStyle:.short)
        DateLabel.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle:.none)
        // Do any additional setup after loading the view.
    }
    ///RELOADS ClassTable
    //IF ITEMS ARE ADDED From Diff View
    @objc func actOnSpecialNotification() {
        ClassTable.reloadData()
    }
    
    
    @objc func tick() {
        TimeLabel.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .none, timeStyle:.short)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (tableView == self.ClassTable) {
            return myPlace.myArray.count
        }
        if(tableView == self.TaskTable){
            return todaysTasks.count
        }
        return 0
    }
    
    // This datasource method will create each cell of the table
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == self.ClassTable) {
            // Do something
            print("CLASS TABLE")
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tableFileTableViewCell
            cell.detailTextLabel?.textAlignment = .right
            cell.label_cell.text = myPlace.myArray[indexPath.row].placeName
            let pic = (myPlace.myArray[indexPath.row].placePic)
            cell.image_Cell.image = UIImage(data: pic! as Data)
            return cell;
        }
        if(tableView == self.TaskTable){
            print("TASK TABLE")
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tableFileTableViewCell
            cell.detailTextLabel?.textAlignment = .right
            cell.label_cell.text = todaysTcomps[indexPath.row][0]///Fix
            return cell;
        }
        else{
         let t = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as! tableFileTableViewCell
            return t
        }
    }
    
    
    func tableView (_ tableview: UITableView , canEditRowAt indexPath: IndexPath)-> Bool
    {
        return true;
    }
    
    func tableView(_ tableView: UITableView , commit editingStyle: UITableViewCellEditingStyle , forRowAt indexPath: IndexPath)
    {
        if (tableView == self.ClassTable) {
            if editingStyle == UITableViewCellEditingStyle.delete
            {
                myPlace.delete(index: indexPath.row)
                myTask.deleteAll(index:indexPath.row)
                self.ClassTable.reloadData()
            }
        }
    }
    
    
    
    //Ready ups the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "details"){
            let selectedIndex: IndexPath = self.ClassTable.indexPath(for: sender as! UITableViewCell)!
            let days = myPlace.myArray[selectedIndex.row].classDays!
            let name = myPlace.myArray[selectedIndex.row].placeName!
            let des = myPlace.myArray[selectedIndex.row].placeDescri!
            let picture = myPlace.myArray[selectedIndex.row].placePic
            if let detailviewController: ClassesViewController = segue.destination as? ClassesViewController {
               detailviewController.days = days
            detailviewController.detailName = name
                detailviewController.Address = des
                detailviewController.pic = picture
                detailviewController.classNumber = selectedIndex.row
                
            }
        }
    }
    func updateDailyTasks()
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let result = dateFormatter.string(from: date)
        print(result)
        var className:[String] = []
        if myTask.taskArray.count > 0
        {
            var x = 0
            for classes in myTask.taskArray
            {
                //myTask.deleteAll(index: x)
                //continue
                print("checks Classes")
                classTasks = (classes.taskComponents?.components(separatedBy: "*$*"))!
                classTasks = classTasks.filter{$0 != ""}
                var i = 0
                let taskInit:[[String]] =  Array(repeating: Array(repeating: "", count: classTasks.count), count: 10)
                ////
                taskComponents = taskInit
                ////
                for task in classTasks
                {
                    taskComponents[i] = (task.components(separatedBy: "|$|"))
                    taskComponents[i] = taskComponents[i].filter{$0 != ""}
                    if(taskComponents[i][1]==result)
                    {
                        className.append(myPlace.myArray[x].placeName!)
                        todaysTasks.append(task)
                        print(task)
                    }
                    i += 1
                }
                x += 1
            }
        }
        todaysTcomps = Array(repeating: Array(repeating: "", count: todaysTasks.count), count: 10)
        var i = 0
        for task in todaysTasks
        {
            todaysTcomps[i] = (task.components(separatedBy: "|$|"))
            todaysTcomps[i] = todaysTcomps[i].filter{$0 != ""}
            //this next part is to just append the class
            //name infront of the task Name.. cause Y not
            var temp = className[i] + ": "
            temp += todaysTcomps[i][0]
            todaysTcomps[i][0] = temp
            i += 1
        }
    }
}

