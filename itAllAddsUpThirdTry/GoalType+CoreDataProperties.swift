//
//  GoalType+CoreDataProperties.swift
//  itAllAddsUpThirdTry
//
//  Created by Raphael Reiter on 22/04/2017.
//  Copyright © 2017 Raphael Reiter. All rights reserved.
//

import Foundation
import CoreData


extension GoalType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GoalType> {
        return NSFetchRequest<GoalType>(entityName: "GoalType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toGoal: Goal?

}
