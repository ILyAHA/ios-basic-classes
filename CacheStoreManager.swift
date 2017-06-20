//
//  CacheStoreManager.swift
//  Breezer
//
//  Created by Admin on 06.04.17.
//  Copyright © 2017 grapes-studio. All rights reserved.
//

import Foundation
import CoreData

let kEntityDevice = "Device"
let kEntityDeviceData = "DeviceData"

//
public class CacheStoreManager
{
    static let shared = CacheStoreManager()
    
    //CoreData stack
    var dataStack: CoreDataStack? = nil
    
    init?() {
        //init core data stack
        guard let ds = CoreDataStack(modelName: "SomeModel") else {
            //if error then nil. and we should notificate user about error and close the app
            return nil
        }
        dataStack = ds
    }
    
	/**
     Get all records 'entityName' sorted by 'sortField'.
     
     - parameter entityName: Entity name.
     - parameter sortField: sortFielf.
     
     - returns: array of NSManagedObject instances or nil.
     */
    func fetch(_ entityName: String, sortField: String) -> [NSManagedObject]?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sort = NSSortDescriptor(key: sortField, ascending: true)
        request.sortDescriptors = [sort]
        do{
            let records = try dataStack?.context.fetch(request) as? [NSManagedObject]
            return records
        }
        catch {
            return nil
        }
    }
    
	/**
     Get record 'entityName' filtered by 'id' field.
     
     - parameter entityName: Entity name.
     - parameter withID: value for filtering by 'id' field.
     
     - returns: NSManagedObject instance or nil
     */
    func fetch(_ entityName: String, withID: String) -> NSManagedObject?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let predicate = NSPredicate(format: "(id = %@)", withID)
        request.predicate = predicate
        do{
            let fetchedRecords = try dataStack?.context.fetch(request) as? [NSManagedObject]
            guard let records = fetchedRecords else{
                return nil
            }
            guard records.count != 0 else{
                return nil
            }
            return records[0]
        }
        catch {
            return nil
        }
    }
    
    //возвратить Device с указанным id. Если не существует - создает новый
	/**
     Get record of 'Device' entity filtered by 'id' field.
     
     - parameter withID: value for filtering by 'id' field.
     
     - returns: NSManagedObject instance or
				create new record and setting 'id' with 'withID' value
     */
    //func device(withID id: String?) -> Device?
    //{
    //    guard id != nil else {
    //        return nil
    //    }
        
        //get entity with id
    //    var result: Device? = self.fetch(kEntityDevice, withID: id!) as? Device
    //    //if nil then new
    //    if (result == nil)
    //    {
    //        result = NSEntityDescription.insertNewObject(forEntityName: kEntityDevice, into: (self.dataStack?.context)!) as? Device
    //        result?.id = id
    //    }
    //    return result
    //}
    
    deinit {
    }
    
    /**
     Save CoreData database.
     
     - returns: nil or error while saving
     */
    func save() -> Error?
    {
        return self.dataStack?.save()
    }
}

