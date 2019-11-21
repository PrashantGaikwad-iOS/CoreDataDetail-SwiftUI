//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Saif on 20/11/19.
//  Copyright © 2019 LeftRightMind. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String
    @NSManaged public var director: String
    @NSManaged public var year: Int16

}
