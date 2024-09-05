//
//  StorageServiceProtocol.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 05.09.2024.
//

import Foundation
import CoreData

protocol StorageServiceProtocol {
    func save()
    func delete(item: NSManagedObject)
    func add(completion: (NSManagedObjectContext) -> Void)
    func item<T: NSManagedObject>(ofType itemType: T.Type, predicate: NSPredicate) -> T?
    func items<T: NSManagedObject>(ofType itemType: T.Type, predicate: NSPredicate) -> [T]?
}
