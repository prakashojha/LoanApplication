//
//  AnyDataService.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 28/10/24.
//

import Foundation

// Type-erased wrapper for DataServiceProtocol
class AnyDataService<T>: DataServiceProtocol {

    private let _fetchData: (@escaping (Result<[T], Error>) -> Void) -> Void
    private let _deleteData: (T, @escaping (Result<Bool, Error>) -> Void) -> Void
    private let _saveData: ( @escaping (Result<Bool, Error>) -> Void) -> Void
    private let _updateData: (T, [String: Any], @escaping (Result<Bool, Error>) -> Void) -> Void
    private let _getEntityToUpdate: (UUID, T) -> T?

    init<U: DataServiceProtocol>(_ service: U) where U.T == T{
        self._fetchData = service.fetchData
        self._deleteData = service.deleteData
        self._saveData = service.saveData
        self._updateData = service.updateData
        self._getEntityToUpdate = service.getEntityToUpdate
    }

    func fetchData(completion: @escaping (Result<[T], Error>) -> Void) {
        _fetchData(completion)
    }
    
    func deleteData(forObject: T, completion: @escaping (Result<Bool, Error>) -> Void) {
        _deleteData(forObject, completion)
    }
    
    func saveData(completion: @escaping (Result<Bool, Error>) -> Void) {
        _saveData(completion)
    }
    
    func updateData(entityToUpdate: T, object: [String: Any], completion: @escaping (Result<Bool, Error>) -> Void){
        _updateData(entityToUpdate, object, completion)
    }
    
    func getEntityToUpdate(withId: UUID, object: T) -> T? {
        _getEntityToUpdate(withId, object)
    }
}
