//
//  Book.swift
//  BookStore_2
//
//  Created by Andres on 4/7/20.
//  Copyright © 2020 mario. All rights reserved.
//

import Foundation

class Book{
    var id: Int
    var price: Int
    var title: String
    var yearPublished: Int
    
    init(id:Int, price: Int, title: String, yearPublished: Int){
        self.id = id
        self.price = price
        self.title = title
        self.yearPublished = yearPublished
    }
}
