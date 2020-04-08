//
//  BookDAO.swift
//  BookStore_2
//
//  Created by Andres on 4/7/20.
//  Copyright © 2020 mario. All rights reserved.
//

import Foundation

import CoreData
import UIKit
class BookDAO{
    
    func addBook(title: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let bookEntity = NSEntityDescription.entity(forEntityName: "Book", in: managedContext)
        var id = getAllBooksOrderedById().last?.id ?? 0
        id = id + 1
        let book = NSManagedObject(entity: bookEntity!, insertInto: managedContext)
        book.setValue("My Book \(id)", forKey: "title")
        book.setValue(id, forKey: "id")
        
        
        //Save the Book into the database
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save. \(error) \(error.userInfo)")
        }
    }
    func getAllBooksOrderedById() -> [Book]{
        var books = [Book]()
        //Returns a Book
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        //Configuration of the fetch request
        
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                let book = Book(id: data.value(forKey: "id") as! Int, price: data.value(forKey: "price") as! Int, title: data.value(forKey: "title") as! String, yearPublished: data.value(forKey: "yearPublished") as! Int)
                books.append(book)
            }
        }catch{
            print("Failed get Book request")
        }
        return books
        
        
    }
    func getAllBooksOrderedByName() -> [Book]{
        var books = [Book]()
        //Returns a Book
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        //Configuration of the fetch request
        
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "title", ascending: true)]
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                
                let book = Book(id: data.value(forKey: "id") as! Int, price: data.value(forKey: "price") as! Int, title: data.value(forKey: "title") as! String, yearPublished: data.value(forKey: "yearPublished") as! Int)
                books.append(book)
                
            }
        }catch{
            print("Failed get Book request")
        }
        return books
        
        
    }
  
    func deleteBook(id: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        do{
            let fetchedRow = try managedContext.fetch(fetchRequest)
            
            
            let objectToDelete = fetchedRow[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            do{
                try managedContext.save()
            }catch{
                print("error delete the Book \(id)")
            }
        }catch{
            print("error trying to delete Book \(id)")
        }
    }
}
