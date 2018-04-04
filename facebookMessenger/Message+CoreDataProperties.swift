//
//  Message+CoreDataProperties.swift
//  facebookMessenger
//
//  Created by Arvids Gargurnis on 04/04/2018.
//  Copyright © 2018 Arvids Gargurnis. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var isSender: Bool
    @NSManaged public var friend: Friend?

}
