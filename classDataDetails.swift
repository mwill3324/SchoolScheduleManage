//
//  classDataDetails.swift
//  Final
//
//  Created by Marcus Williams on 11/15/17.
//  Copyright © 2017 Marcus Williams. All rights reserved.
//

import Foundation
import CoreData

extension Classes {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Classes> {
        return NSFetchRequest<Classes>(entityName: "Places")
    }

    @NSManaged public var Days: String?
    @NSManaged public var placeName: String?
    @NSManaged public var placeDescri: String?
    @NSManaged public var placePic: NSData?
    @NSManaged public var classLocation: String?
    //@NSManaged public var Days: Int
}
