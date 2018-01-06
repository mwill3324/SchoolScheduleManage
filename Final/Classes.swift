//
//  ClassesViewController.swift
//  Final
//
//  Created by Marcus Williams on 11/14/17.
//

import UIKit
var newName2 = ""
var newPic2:NSData? = nil
var newaddress2 = ""


class ClassesViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate,
UITableViewDataSource , UITableViewDelegate {
    
    //////////////////////////////
    var detailName :String!
    var Address: String!
    var pict : String!
    var pic : NSData!
    var detailPlace : place = place()
    var classNumber = 0
    var TaskNumber = 0
    var days:String!
    ///////////////////////////////
    @IBOutlet weak var DaysBox: UITextView!
    @IBOutlet var daysLabel: UILabel!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet var EditB: UIBarButtonItem!
    @IBOutlet var AddressLabel: UILabel!
    @IBOutlet var taskTable: UITableView!
    
    var classTasks:[String] = []
    var taskComponents:[[String]] = [[]]
    func refresh()
    {
        if myTask.taskArray.count > 0
        {
            myTask.load()
            classTasks = (myTask.taskArray[classNumber].taskComponents?.components(separatedBy: "*$*"))!
            classTasks = classTasks.filter{$0 != ""}
            var i = 0
            let taskInit:[[String]] =  Array(repeating: Array(repeating: "", count: classTasks.count), count: classTasks.count)
            taskComponents = taskInit
            print (classTasks)
            for task in classTasks
            {
                taskComponents[i] = (task.components(separatedBy: "|$|"))
                taskComponents[i] = taskComponents[i].filter{$0 != ""}
                i += 1
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myTask.load()
       refresh()
    NotificationCenter.default.addObserver(self, selector: #selector(ClassesViewController.actOnSpecialNotification), name: NSNotification.Name(rawValue: mySpecialNotificationKey), object: nil)
        
        AddressLabel.text = Address
        nameLbl.text = detailName
        selectedImage.image = UIImage(data: pic as Data)
        newName2 = detailName
        newPic2 = pic
        newaddress2 = Address
        DaysBox.text = days
        var daysFixed:String = ""
        ////////FixDays/////////////
        if days.contains("1")
        {
            daysFixed += "Sunday\n"
        }
        if days.contains("2")
        {
            daysFixed += "Monday\n"
        }
        if days.contains("3")
        {
            daysFixed += "Tuesday\n"
        }
        if days.contains("4")
        {
            daysFixed += "Wednesday\n"
        }
        if days.contains("5")
        {
            daysFixed += "Thursday\n"
        }
        if days.contains("6")
        {
            daysFixed += "Friday\n"
        }
        if days.contains("7")
        {
            daysFixed += "Saturday\n"
        }
        DaysBox.text = daysFixed
        
        taskTable.reloadData()
    }
    
    @objc func actOnSpecialNotification() {
        refresh()
        print("Loaded")
        myTask.load()
        taskTable.reloadData()
        nameLbl.text = newName2
        selectedImage.image = UIImage(data: newPic2! as Data)
        AddressLabel.text = newaddress2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return classTasks.count
    }
    // This datasource method will create each cell of the table
     func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tableFileTableViewCell
         cell.detailTextLabel?.textAlignment = .right
         cell.label_cell.text = taskComponents[indexPath.row][0]
         return cell;
     }
    func tableView (_ tableview: UITableView , canEditRowAt indexPath: IndexPath)-> Bool
    {
        return true;
    }
    
    func tableView(_ tableView: UITableView , commit editingStyle: UITableViewCellEditingStyle , forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            myTask.delete(index: indexPath.row, classNum: classNumber) //also to fix
            refresh()
            taskTable.reloadData()
        }
    }
    //////////
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toEdit"){
            let name = myPlace.myArray[classNumber].placeName!
            let des = myPlace.myArray[classNumber].placeDescri!
            let picture = myPlace.myArray[classNumber].placePic
            let theDays = myPlace.myArray[classNumber].classDays
            if let detailviewController: ViewDetailsController = segue.destination as? ViewDetailsController {
                detailviewController.detailName = name
                detailviewController.detailDesc = des
                detailviewController.pic = picture
                detailviewController.index = classNumber
                detailviewController.days = theDays
            }
        }
        if(segue.identifier == "addTask"){
            let ClassName = myPlace.myArray[classNumber].placeName!
             if let taskAdder: AddTask = segue.destination as? AddTask {
                taskAdder.className = ClassName
                taskAdder.classNum = classNumber
            }
        }
        if(segue.identifier == "showTask"){
            let selectedIndex: IndexPath = self.taskTable.indexPath(for: sender as! UITableViewCell)!
            let ClassName = myPlace.myArray[classNumber].placeName!
            if let showTask: ShowTask = segue.destination as? ShowTask {
                showTask.taskComps = classTasks[selectedIndex.row]
                showTask.cName = ClassName
                showTask.ClassNumber = classNumber
                showTask.TaskNumber = selectedIndex.row
            }
        }
        if(segue.identifier == "goMap"){
            let ClassName = myPlace.myArray[classNumber].placeName!
            if let goMap: DoSomeMapShiz = segue.destination as? DoSomeMapShiz {
                goMap.address = Address
                goMap.ClassName = ClassName
            }
        }
            
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


