//
//  Image+CoreDataProperties.swift
//  itAllAddsUpThirdTry
//
//  Created by Raphael Reiter on 22/04/2017.
//  Copyright © 2017 Raphael Reiter. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toGoal: Goal?

}
