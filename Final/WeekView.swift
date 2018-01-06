//
//  WeekView.swift
//  Final
//
//  Created by Marcus Williams on 11/18/17.
//  Copyright © 2017 Marcus Williams. All rights reserved.
//

import UIKit

class WeekView: UIViewController, UITableViewDataSource , UITableViewDelegate  {

    @IBOutlet weak var WeekTable: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    ////////////////////
    var todaysTasks:[String] = []
    var todaysTcomps:[[String]] = [[]]
    var classTasks:[String] = []
    var taskComponents:[[String]] = [[]]
    var WeekTasks:[[String]] = Array(repeating: Array(repeating: "", count: 1), count: 7)
    //////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let result = dateFormatter.string(from: date)
        dateLabel.text = result
        updateDailyTasks()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 55.0;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return WeekTasks.count
    }
    
    // This datasource method will create each cell of the table
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Do something
            print("CLASS TABLE")
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! weekViewTableCell
            cell.detailTextLabel?.textAlignment = .right
            cell.Label1.text = WeekTasks[indexPath.row][1]
            cell.Label2.text = WeekTasks[indexPath.row][2]
            cell.Label3.text = WeekTasks[indexPath.row][3]
            cell.Label4.text = WeekTasks[indexPath.row][4]
            cell.Label5.text = WeekTasks[indexPath.row][5]
        return cell
    }
    func tableView (_ tableview: UITableView , canEditRowAt indexPath: IndexPath)-> Bool
    {
        return true;
    }
    func tableView(_ tableView: UITableView , commit editingStyle: UITableViewCellEditingStyle , forRowAt indexPath: IndexPath)
    {
    }
    func updateDailyTasks()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        if myTask.taskArray.count > 0
        {
            var x = 0
            
            for classes in myTask.taskArray
            {   //used this to delete all the old tasks
                //myTask.deleteAll(index: x)
                //continue
                classTasks = (classes.taskComponents?.components(separatedBy: "*$*"))!
                classTasks = classTasks.filter{$0 != ""}
                let taskInit:[[String]] =  Array(repeating: Array(repeating: "", count: classTasks.count), count: 10)
                taskComponents = taskInit
                var i = 0
                for task in classTasks
                {
                    taskComponents[i] = (task.components(separatedBy: "|$|"))
                    taskComponents[i] = taskComponents[i].filter{$0 != ""}
                    for y in 0...6
                    {
                        //Set Week Array to Start At Sunday
                        //So the beginning of the week is where we start
                        //regardless of todays date...
                        let calendar = Calendar.current
                        let daysFromSunday = calendar.component(.weekday, from: Date()) - 1
                        let temp = y - daysFromSunday
                        let day = calendar.date(byAdding: .day, value: temp, to: Date())
                        let newDate = dateFormatter.string(from: day!)
                        print(newDate)
                        if(taskComponents[i][1]==newDate)
                        {
                            WeekTasks[y].append(taskComponents[i][0])
                            print(task)
                        }
                    }
                    i += 1
                }
                x += 1
            }
        }
        //Just to fill the rest with empty strings
        //to avoid any out of bound exception
        for n in 0...6
        {
            for _ in 0...6
            {
                if(WeekTasks[n].count==6)
                {
                    continue
                }else
                {
                    WeekTasks[n].append("")
                }
            }
        }
        print(WeekTasks)
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
