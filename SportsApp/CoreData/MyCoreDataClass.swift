//
//  MyCoreDataClass.swift
//  MyCoreDataClass
//
//  Created by Said Elsoudany on 2/8/21.
//  Copyright © 2021 Said Elsoudany. All rights reserved.
//

import UIKit
import CoreData

class MyCoreDataClass{
    var appDelegate : AppDelegate?
    var managedContext : NSManagedObjectContext?
    static let shared  = MyCoreDataClass()
    private init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate!.persistentContainer.viewContext
    }
    
    func saveToCoreData(league : League)
    {
        
        let entity = NSEntityDescription.entity(forEntityName: "Leagues", in: managedContext!)
        let savedLeague = Leagues(entity: entity!, insertInto: managedContext)
        
        savedLeague.id = league.leagueId
        savedLeague.leagueBadge = league.leagueBadge
        savedLeague.leagueName = league.leagueName
        savedLeague.leagueYTUrl = league.leagueLink
        
        do
        {
            try managedContext!.save()
        }catch let error
        {
            print(error)
        }
        
        
    }
    func fetchFromCoreDataWithId(id : String) -> Bool {
        var retArray = [Leagues]()
        let appDelgate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelgate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Leagues>(entityName: "Leagues")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do{
            retArray = try managedContext.fetch(fetchRequest)
        }catch let error
        {
            print(error)
        }
        let arrOfIds = retArray.map { (league) -> String in
            league.id!
        }
        return arrOfIds.contains(id)
    }
    func fetchfromCoreData() -> [Leagues]
    {
        var retArray = [Leagues]()
        let appDelgate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelgate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Leagues>(entityName: "Leagues")
        
        
        do{
            retArray = try managedContext.fetch(fetchRequest)
        }catch let error
        {
            print(error)
        }
        return retArray
    }
    func deleteFromCoreData(id : String)
    {
        let fetchRequest = NSFetchRequest<Leagues>(entityName: "Leagues")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        let delete = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do
        {
            try managedContext?.execute(delete)
        }catch let error
        {
            print(error)
        }
        
        
    }
    
    
}
