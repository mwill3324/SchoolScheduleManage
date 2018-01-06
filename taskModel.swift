//
//  taskModel.swift
//  Final
//
//  Created by Marcus Williams on 11/15/17.
//  Copyright © 2017 Marcus Williams. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class task
{
    var taskArray :[Tasks] = [Tasks]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func addSpot()
    {
        let ent = NSEntityDescription.entity(forEntityName: "Tasks", in: self.managedObjectContext)
        let oneTask = Tasks(entity: ent!, insertInto: managedObjectContext)
        oneTask.taskComponents = ""
        do
        {
            try managedObjectContext.save()
        }
        catch let error
        {
            _ = error.localizedDescription
        }
        load()
    }
    func clearData()
    {
        for item in taskArray
        {
            managedObjectContext.delete(item)
        }
        do {
            try  managedObjectContext.save()
        }
        catch {
            print("ERROR")
        }
        load()
    }
    
    func add(components: String,classNum:Int)
    {
        /*
        let ent = NSEntityDescription.entity(forEntityName: "Tasks", in: self.managedObjectContext)
        let oneTask = Tasks(entity: ent!, insertInto: managedObjectContext)
        oneTask.taskComponents = components
 
         */
        print("coreDataSave-")
        taskArray[classNum].taskComponents = components
        print(components)
        do
        {
            try managedObjectContext.save()
            print("tf is wrong")
            print(myTask.taskArray[classNum].taskComponents)
            print("tfffff")
        }
        catch let error
        {
            _ = error.localizedDescription
        }
        load()
    }
    
    func delete(index:Int, classNum: Int)
    {
        var classTasks:[String] = []
        print("DELETE")
        if myTask.taskArray.count > 0
        {
            print("DEeeeeeeeeeefwfsdfadsfasdfasdfasdfasdfasdf")
            classTasks = (myTask.taskArray[classNum].taskComponents?.components(separatedBy: "*$*"))!
            classTasks = classTasks.filter{$0 != ""}
            print(classTasks)
            classTasks.remove(at: index)
        }
        //Removes the task.. Now have to reConcat the string
        //Adding in delims
        //Don't judge my use of string splits
        var newString = ""
        for items in classTasks
        {
            newString += "*$*" + items
        }
        taskArray[classNum].taskComponents = newString
        print("--")
        print(newString)
        print("--")
        //let item = taskArray[index]
        //managedObjectContext.delete(item)
        do {
            try  managedObjectContext.save()
        }
        catch {
            print("ERROR")
        }
        load()
    }
    func deleteAll(index:Int)
    {
        let item = taskArray[index]
        managedObjectContext.delete(item)
        do {
            try  managedObjectContext.save()
        }
        catch {
            print("ERROR")
        }
        load()
    }
    func editAll(newComp: String,taskNum : Int)
    {
        print("EDIT")
        load()
        taskArray[taskNum].taskComponents = newComp
        do {
            try  managedObjectContext.save()
        }
        catch {
            print("ERROR")
        }
        load()
    }
    
    func load()
    {
        var results : [Tasks]!
        let request: NSFetchRequest<Tasks> = Tasks.fetchRequest() as NSFetchRequest<Tasks>
        do {
            results =
                try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Tasks]
            self.taskArray =  results
            
        }catch
        {
            print("ERROR")
        }
    }
    
    func selectingPicture()
    {
        //let ent = NSEntityDescription.entity(forEntityName: Places, in: self.managedObjectContext)
        
    }
    
}


