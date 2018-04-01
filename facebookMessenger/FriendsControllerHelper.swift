//
//  FriendsControllerHelper.swift
//  facebookMessenger
//
//  Created by Arvids Gargurnis on 01/04/2018.
//  Copyright © 2018 Arvids Gargurnis. All rights reserved.
//

import UIKit
import CoreData

extension FriendsController {
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            do {
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: Message.fetchRequest())
                try context.execute(deleteRequest)
                let friendsDeleteRequest = NSBatchDeleteRequest(fetchRequest: Friend.fetchRequest())
                try context.execute(friendsDeleteRequest)
                messages?.removeAll()
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func setupData() {
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            
            mark.name = "Mark Zuckerberg"
            mark.profileImageName = "zuckprofile"
            
            let messageMark = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageMark.friend = mark
            messageMark.text = "Hello, my name is Mark. Nice to meet you!"
            messageMark.date = NSDate()
            
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Jobs"
            steve.profileImageName = "steve_profile"
            
            createMessageWithText(text: "Good morning Arvid", friend: steve, minutesAgo: 3, context: context)
            createMessageWithText(text: "How are you this morning?", friend: steve, minutesAgo: 2, context: context)
            createMessageWithText(text: "Are you interested in buying an Apple device?", friend: steve, minutesAgo: 1, context: context)
            
            let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            donald.name = "Donald Trump"
            donald.profileImageName = "donald_trump_profile"
            createMessageWithText(text: "You're fired!", friend: donald, minutesAgo: 5, context: context)
            
            do {
                try(context.save())
            } catch let err {
                print(err)
            }
        }
        loadData()
    }
    
    private func createMessageWithText(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext) {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(-minutesAgo * 60)
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            if let friends = fetchFriends() {
                
                messages = [Message]()
                
                for friend in friends {
                    
                    let fetchRequest: NSFetchRequest<Message> = Message.fetchRequest()
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                    fetchRequest.fetchLimit = 1
                    
                    do {
                        
                        let fetchedMessages = try context.fetch(fetchRequest)
                        messages?.append(contentsOf: fetchedMessages)
                    } catch let err {
                        print(err)
                    }
                }
                messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
            }
        }
    }
    
    private func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            let request: NSFetchRequest<Friend> = Friend.fetchRequest()
            
            do {
                return try context.fetch(request)
            } catch let err {
                print(err)
            }
        }
        return nil
    }
}
