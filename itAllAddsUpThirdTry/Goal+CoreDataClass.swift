//
//  Goal+CoreDataClass.swift
//  itAllAddsUpThirdTry
//
//  Created by Raphael Reiter on 22/04/2017.
//  Copyright © 2017 Raphael Reiter. All rights reserved.
//

import Foundation
import CoreData

@objc(Goal)
public class Goal: NSManagedObject {
    
    public override func awakeFromInsert() {
        
        super.awakeFromInsert()
        
        self.created = NSDate()
}

}
