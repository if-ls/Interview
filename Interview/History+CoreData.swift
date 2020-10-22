//
//  History+CoreData.swift
//  Interview
//
//  Created by Wang on 2020/10/22.
//  Copyright © 2020 if-ls. All rights reserved.
//

import UIKit
import CoreData

extension History {
    
    static var delegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    static var context: NSManagedObjectContext {
        delegate.persistentContainer.viewContext
    }
    
    static func insert(status: Bool, resp: Data?) {
        if let his = NSEntityDescription.insertNewObject(forEntityName: "History", into: context) as? History {
            his.url = "https://api.github.com"
            his.timestamp = Date().timeIntervalSince1970
            his.status = status
            his.resp = resp
            
            do {
                try context.save()
                NotificationCenter.default.post(name: NSNotification.Name("CanRefresh"), object: nil)
            } catch let err {
                print("Save Error:\(err)")
            }
        } else {
            print("Insert Error")
        }
    }
    
    static func fetch(limit: Int = 0) -> [History] {
        let req: NSFetchRequest<History> = History.fetchRequest()
        req.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        if limit != 0 {
            req.fetchLimit = limit
        }
        
        do {
            let result = try context.fetch(req)
            return result
        } catch {
            return []
        }
    }
    
    static func get() -> History? {
        let result = fetch(limit: 1)
        return result.first
    }
}
