//
//  CoreData.swift
//  CoreNotes
//
//  Created by Anjel Villafranco on 11/17/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit
import CoreData


extension NSManagedObject {
    
    class func delegateAndEntity(name: String) -> (NSManagedObjectContext, NSEntityDescription)? {
        
        guard let _appDelegate = _appDelegate else { return nil }
        
        guard let entity = NSEntityDescription.entityForName("Category", inManagedObjectContext: _appDelegate.managedObjectContext) else { return nil }
        
        return (_appDelegate.managedObjectContext,entity)
        
    }
    
}

class Category: NSManagedObject {
    
    class func category() -> Category? {
        
        guard let (moc, entity) = delegateAndEntity("Category") else { return nil }
        
        return Category.init(entity: entity, insertIntoManagedObjectContext: moc)
        
    }
    
    var name = valueForKey("name") as? String
    
    var text: String? {
        
        get { return valueForKey("name") as? String }
        set { setValue(newValue, forKey: "name") }
        
    }
    
}

class Note: NSManagedObject {
    
    class func note() -> Note? {
    
        guard let (moc, entity) = delegateAndEntity("Note") else { return nil }
    
        return Note.init(entity: entity, insertIntoManagedObjectContext: moc)

    }
    
    var text: String? {
        
        get { return valueForKey("text") as? String }
        set { setValue(newValue, forKey: "text") }
        
    }
    
    var category: NSManagedObject? {
        
        get { return valueForKey("category") as? NSManagedObject }
        set { setValue(newValue, forKey: "category") }
    
    }

        
}


struct CategoryDictionary {
    
    var category: Category!
    var notes: [Note] = []
    
}

private let _appDelegate = { return UIApplication.sharedApplication().delegate as? AppDelegate }()

extension NotesTVC: Fetchable {
    
    func fetchCategoriesAndNotes() {
        
        categories = []
        
        fetchEntity("Category", predicates: nil) { (found) -> () in
            
            guard let categories = found as? [Category] else { return }
            
            for category in categories {
                
                var newCategoryD = CategoryDictionary()
                
                newCategoryD.category = category
                
                let predicate = NSPredicate(format: "category == %@", category)
                
                self.fetchEntity("Note", predicates: [predicate], completion: { (found) -> () in
                    
                    newCategoryD.notes = found as? [Note] ?? []
                    
                })
                
                self.categories.append(newCategoryD)
                
                print(self.categories)
                
                self.tableView.reloadData()
            }
            
        }
        
    }
    
}
extension NewNoteVC: Fetchable  {
    
    func fetchCategories() {
        
        
        fetchEntity("Category", predicates: nil) { (found) -> () in
            
            print(found)
            
            self.categories = found as? [Category] ?? []
            self.categoryPicker.reloadAllComponents()
            
        }
        
    }
    func createNote() {
        
        let newNote = Note.note()
        newNote?.text = noteTextView.text
        newNote?.category = categories[categoryPicker.selectedRowInComponent(0)]
        
        _appDelegate?.saveContext()
    }
}
//MARK: - New Note
extension NewCategoryVC {
    
    func createCategory() {
        
        let newCategory = Category.category()
        newCategory?.name = categoryNameField.text
        
        _appDelegate?.saveContext()
        
    }
}
protocol Fetchable {
    
    func fetchEntity(name: String, predicates: [NSPredicate]?, completion: (found: [AnyObject]) -> ())
    
}
extension Fetchable {
    
    func fetchEntity(name: String, predicates: [NSPredicate]?, completion: (found: [AnyObject]) -> ()) {
        
        //fetch categories
        
        let request = NSFetchRequest(entityName: name)
        
        //do something with predicates latet
        
        guard let foundObjects = try? _appDelegate?.managedObjectContext.executeFetchRequest(request) ?? [] else { return completion (found: []) }
        
        completion(found: foundObjects)
        
    }
}