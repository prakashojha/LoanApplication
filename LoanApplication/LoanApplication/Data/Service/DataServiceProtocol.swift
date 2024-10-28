//
//  DataServiceProtocol.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 28/10/24.
//

import Foundation

protocol DataServiceProtocol {
    // Generic method to fetch data
    associatedtype T
    
    func fetchData(completion: @escaping (Result<[T], Error>) -> Void)
    func deleteData(forObject: T, completion: @escaping (Result<Bool, Error>) -> Void)
    func saveData(completion: @escaping (Result<Bool, Error>) -> Void)
    func updateData(entityToUpdate: T, object: [String: Any], completion: @escaping (Result<Bool, Error>) -> Void)
    //func updateData(withId: UUID, object:T, completion: @escaping (Result<Bool, Error>) -> Void)
    func getEntityToUpdate(withId: UUID, object: T) -> T?
}
