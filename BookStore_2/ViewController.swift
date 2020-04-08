//
//  ViewController.swift
//  BookStore_2
//
//  Created by Andres on 3/31/20.
//  Copyright © 2020 mario. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet var myTableView: UITableView!
    var books = [Book]()
    let bookDAO = BookDAO()
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        books = bookDAO.getAllBooksOrderedByName()
    }
    @IBAction func addNew(_ sender: UIBarButtonItem) {
        bookDAO.addBook(title: "notimplementedYet")
        books = bookDAO.getAllBooksOrderedByName()
        myTableView.reloadData()
    }
    
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let id = books[indexPath.row].id
            books.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            bookDAO.deleteBook(id: id)
            tableView.endUpdates()
            books = bookDAO.getAllBooksOrderedByName()
            myTableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            else{
                return UITableViewCell()
        }
        let book: Book = books[indexPath.row]
        cell.textLabel?.text = book.title
        return cell
    }
    
    
}

