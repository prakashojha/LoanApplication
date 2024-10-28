//
//  CoreDataService.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 28/10/24.
//

import Foundation
import CoreData

class CoreDataService<T: NSManagedObject, U: NSManagedObject>: DataServiceProtocol {
    
    private let context: NSManagedObjectContext
    private let mapper: ([T]) -> [U]
    
    init(context: NSManagedObjectContext, mapper: @escaping ([T]) -> [U]) {
        self.context = context
        self.mapper = mapper
    }
    
    func fetchData(completion: @escaping (Result<[U], Error>) -> Void) {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let _ = results.first {
                let mappedResult = mapper(results)
                completion(.success(mappedResult))
            } else {
                completion(.failure(NSError(domain: "No data found", code: -1, userInfo: nil)))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteData(forObject: U, completion: @escaping (Result<Bool, Error>) -> Void) {
        context.delete(forObject)
        saveData(completion: completion)
    }
    
    func saveData(completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try context.save()
            completion(.success(true))
        } catch {
            completion(.failure(NSError(domain: "Failed to delete object: \(error)", code: -1, userInfo: nil)))
        }
    }
    
    func getEntityToUpdate<T:NSManagedObject>(withId: UUID, object: T) -> T? {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        
        // Use the predicate to find the specific entity with the matching UUID
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", withId as CVarArg)
        let entityToUpdate = try? context.fetch(fetchRequest).first
        
        return entityToUpdate
    }
    
    func updateData<U:NSManagedObject>(entityToUpdate: U, object: [String: Any], completion: @escaping (Result<Bool, Error>) -> Void) {
        for (key, value) in object {
            // Use KVC to set value for the property
            entityToUpdate.setValue(value, forKey: key)
        }
        
        // Save the context to persist changes
        do {
            try context.save()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
        
    }

    
    
//    func updateData(withId: UUID, object: U, completion: @escaping (Result<Bool, Error>) -> Void) {
//
//        let fetchRequest = NSFetchRequest<LoanApplicationCDModel>(entityName: "LoanApplicationCDModel")
//
//            // Use the predicate to find the specific loan by its UUID
//            fetchRequest.predicate = NSPredicate(format: "identifier == %@", withId as CVarArg)
//
//            do {
//                // Fetch the LoanApplicationCDModel
//                if let loanToUpdate = try context.fetch(fetchRequest).first {
//                    // Update the loan's properties using the provided data
////                    for (key, value) in updatedLoanData {
////                        loanToUpdate.setValue(value, forKey: key)
////                    }
//
//                    // Save the context to persist changes
//                    try context.save()
//                    completion(.success(true))
//                } else {
//                    // No matching loan found
//                    completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Loan not found."])))
//                }
//            } catch {
//                // Handle any errors during fetch or save
//                completion(.failure(error))
//            }
//    }
    
}

