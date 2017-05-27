//
//  Goal+CoreDataProperties.swift
//  itAllAddsUpThirdTry
//
//  Created by Raphael Reiter on 22/04/2017.
//  Copyright © 2017 Raphael Reiter. All rights reserved.
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var lastEntry: String?
    @NSManaged public var plusOnes: Int16
    @NSManaged public var title: String?
    @NSManaged public var toGoalType: GoalType?
    @NSManaged public var toImage: Image?

}
