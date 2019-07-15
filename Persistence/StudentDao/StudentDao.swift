//
//  File.swift
//  Persistence
//
//  Created by Admin on 6/20/19.
//  Copyright © 2019 NessaHope. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StudentDao{
    
    var appDelegate:AppDelegate?
    
    init(delegate:AppDelegate){
        appDelegate = delegate
    }
    
    func getManagedContext() -> NSManagedObjectContext? {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        return managedContext
    }
    
    
    func getStudentByID(id: String) -> Student? {
        let context = getManagedContext()!
        let fetchReq = NSFetchRequest<NSFetchRequestResult> (entityName: "Student")
        fetchReq.predicate = NSPredicate(format: "stID = %@", id)
        do{
            let result = try context.fetch(fetchReq)
            if result.count > 0 {
                let name = result[0] as! Student
                return name
            } else{
                print("Student with id= \(id) not found")
                return nil
            }
        }catch{
            print("Cannot fetch from CoreData!")
            return nil
        }
    }
    
    func saveStudent(student: studentForm) -> Bool {
        //if we can save the user return true else false
        let request:NSFetchRequest<Student> = Student.fetchRequest()
        let id = student.stID
        request.predicate = NSPredicate(format: "stID == %@", id)
        let context = getManagedContext()!
        let toSave = Student(context: context)
        toSave.name = student.name
        toSave.password = student.password
        toSave.semester = student.semester
        toSave.stID = id
        
        do{
            let foundUser = try context.fetch(request)
            if (foundUser.count > 0){
                print("Username already taken!")
                return false
            }
            else {
                do{
                    try context.save()
                    print("Saved User!")
                }catch {
                    print("Error saving to CoreData!", error.localizedDescription)
                }
                return true
            }
        } catch {
            print("Failed to look into database, ", error.localizedDescription)
            return false
        }
        
        /*
         if let existing = getUserByUsername(username: user.username!){
         print("User with username=\(existing.username!) already exists!")
         return false
         }
         let conext = getManagedContext()!
         let toSave = User(context: context)
         toSave.username = user.username
         toSav.password = user.password
         do{
         try context.save()
         return true
         } catch {
         print("[ERROR] CoreData error!")
         return false
         }
         */
    }
    
    func getAllUsers() -> [Student] {
        let context = getManagedContext()
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "Student")
        do{
            let result = try context?.fetch(request) as! [Student]
            print("All Users Fetched!")
            return result
        } catch{
            print("error", error.localizedDescription)
        }
        return []
        
        /*
         let context = getManagedContext()
         let fetReq = NSFetchRequest<NSFetchRequestResult> (entityname: "User")
         do{
         let result = try context.fetch(fetchReq) as! [User]
         if result.count > 0 {
         lreturn result
         } else{
         print("[ERROR] No registered yet!")
         return []
         */
        
        
    }
    
}
