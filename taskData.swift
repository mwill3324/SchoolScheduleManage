//
//  taskdata.swift
//  Final
//
//  Created by Marcus Williams on 11/14/17.
//
import Foundation
import CoreData


public class myTasks: NSManagedObject {
    
}

extension myTasks {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks>
    {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }
    
    @NSManaged public var taskComponent: String?
}
