//
//  classModel.swift
// Final
//
//  Created by Marcus Williams on 11/14/17.
//
import Foundation
import CoreData
import UIKit

class place
{
    var myArray : [Places] = [Places]()
    let managedObjectContextTasks = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func add (name: String , descr: String , pic : Data?, days: String)
    {
        let ent = NSEntityDescription.entity(forEntityName: "Places", in: self.managedObjectContextTasks)
        let onePlace = Places(entity: ent!, insertInto: managedObjectContextTasks)
        
        onePlace.classDays = days
        onePlace.placeName = name
        onePlace.placeDescri = descr
        onePlace.placePic = (pic! as NSData)
        
        do
        {
            try managedObjectContextTasks.save()
        }
            
        catch let error
        {
            _ = error.localizedDescription
        }
        load()
    }
    
    
    func delete(index:Int)
    {
        let item = myArray[index]
        managedObjectContextTasks.delete(item)
        do {
            try  managedObjectContextTasks.save()
        }
        catch {
            print("ERROR")
        }
        
        load()
        
    }
    
    
    func editAll(name: String , descr: String , pic : Data? , ind : Int, Days:String)
    {
        load()
        // myArray[ind].Days = Days
        myArray[ind].placeName = name
        myArray[ind].placeDescri = descr
        myArray[ind].placePic = pic! as NSData
        do {
            try  managedObjectContextTasks.save()
        }
        catch {
            print("ERROR")
        }
        
        load()
        
    }
    
    func editNameDes(name: String , descr: String , ind : Int)
    {
        load()
        myArray[ind].placeName = name
        myArray[ind].placeDescri = descr
        //myArray[ind].placePic = pic
        do {
            try  managedObjectContextTasks.save()
        }
        catch {
            print("ERROR")
        }
        
        load()
        
    }
    
    func editName(name: String , ind : Int)
    {
        load()
        myArray[ind].placeName = name
        do {
            try  managedObjectContextTasks.save()
        }
        catch {
            print("ERROR")
        }
        
        load()
        
    }
    
    
    func editDesc(desc: String , ind : Int)
    {
        load()
        myArray[ind].placeDescri = desc
        do {
            try  managedObjectContextTasks.save()
        }
        catch {
            print("ERROR")
        }
        
        load()
        
    }
    
    
    func editNamePic(name: String , pic:Data?,  ind : Int)
    {
        load()
        myArray[ind].placeName = name
        myArray[ind].placePic = pic! as NSData
        
        do {
            try  managedObjectContextTasks.save()
        }
        catch {
            print("ERROR")
        }
        
        load()
        
    }
    
    
    
    func editDescPic(desc: String , pic:Data?,  ind : Int)
    {
        load()
        myArray[ind].placeDescri = desc
        myArray[ind].placePic = pic! as NSData
        
        do {
            try  managedObjectContextTasks.save()
        }
        catch {
            print("ERROR")
        }
        
        load()
        
    }
    func editPic( pic: Data? , ind : Int)
    {
        load()
        myArray[ind].placePic = pic! as NSData
        
        do {
            try  managedObjectContextTasks.save()
        }
        catch {
            print("ERROR")
        }
        
        load()
        
    }
    
    func load()
    {
        var results : [Places]!
        let request: NSFetchRequest<Places> = Places.fetchRequest() as NSFetchRequest<Places>
        do {
            results =
                try managedObjectContextTasks.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Places]
            self.myArray =  results
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

