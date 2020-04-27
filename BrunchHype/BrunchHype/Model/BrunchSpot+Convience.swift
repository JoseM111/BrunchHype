//
//  BrunchSpot+Convience.swift
//  BrunchHype
//
//  Created by Karl Pfister on 4/23/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

extension BrunchSpot {
    @discardableResult
    
    // Default initializer
    convenience init(name: String, tier: String = "Unrated", summary: String = "No summary added",
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        // MARK: _Your designated initializer must be called. The static
        //context gives us access to the context object in CoreDataStack
        self.init(context: context)
        self.name = name
        self.tier = tier
        self.summary = summary
    }
}


