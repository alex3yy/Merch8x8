//
//  StorageService.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 05.09.2024.
//

import Foundation
import CoreData

final class StorageService: ObservableObject {
    static let shared = StorageService()

    // Create a persistent container as a lazy variable to defer instantiation until its first use.
    lazy var persistentContainer: NSPersistentContainer = {

        // Pass the data model filename to the container’s initializer.
        let container = NSPersistentContainer(name: "PersistenceLayer")

        // Load any persistent stores, which creates a store if none exists.
        container.loadPersistentStores { _, error in
            if let error {
                // Handle the error appropriately. However, it's useful to use
                // `fatalError(_:file:line:)` during development.
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()

    private init() { }
}

extension StorageService: StorageServiceProtocol {
    // Add a convenience method to commit changes to the store.
    func save() {
        // Verify that the context has uncommitted changes.
        guard persistentContainer.viewContext.hasChanges else { return }

        do {
            // Attempt to save changes.
            try persistentContainer.viewContext.save()
        } catch {
            // Handle the error appropriately.
            print("Failed to save the context:", error.localizedDescription)
        }
    }

    func delete(item: NSManagedObject) {
        persistentContainer.viewContext.delete(item)
        save()
    }

    func add(completion: (NSManagedObjectContext) -> Void) {
        completion(persistentContainer.viewContext)
        save()
    }

    func item<T: NSManagedObject>(ofType itemType: T.Type, predicate: NSPredicate) -> T? {
        let context = persistentContainer.viewContext

        let nsFetchRequest = itemType.fetchRequest()
        nsFetchRequest.predicate = predicate

        let item = try? context.fetch(nsFetchRequest).first as? T
        return item
    }

    func items<T: NSManagedObject>(ofType itemType: T.Type, predicate: NSPredicate) -> [T]? {
        let context = persistentContainer.viewContext

        let nsFetchRequest = itemType.fetchRequest()
        nsFetchRequest.predicate = predicate

        let items = try? context.fetch(nsFetchRequest) as? [T]
        return items
    }
}
