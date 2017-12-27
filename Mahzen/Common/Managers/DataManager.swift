//
//  DataManager.swift
//  Mahzen
//
//  Created by Said Ozcan on 25/12/2017.
//  Copyright © 2017 SaidOzcan. All rights reserved.
//

import Foundation
import Unbox

enum DataManagerRetrivalArrayResult<T> {
    case success([T])
    case failure(Error)
}

enum DataManagerRetrivalError: Error{
    case noSuchFileFound(fileName:String)
    case mappingError(message: String)
    case jsonDataReadingError(message: String)
    
    var description: String{
        switch self{
        case .noSuchFileFound(let fileName):
            return "No file found named: \(fileName)"
        case .jsonDataReadingError(let message):
            return message
        case .mappingError(let message):
            return message
        }
    }
}

class DataManager: NSObject {
    
    func fetchVenues(_ completionHandler: @escaping (DataManagerRetrivalArrayResult<Venue>) -> Void){
        readJSON { (result) in
            completionHandler(result)
        }
    }
    
    fileprivate func readJSON(with completion:(DataManagerRetrivalArrayResult<Venue>)->Void){
        guard let path = Bundle.main.path(forResource: "places", ofType: "json") else {
            let error = DataManagerRetrivalError.noSuchFileFound(fileName: "places.json")
            completion(DataManagerRetrivalArrayResult.failure(error))
            return
        }
        
        do{
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            
            guard let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSArray else{
                let readingError = DataManagerRetrivalError.jsonDataReadingError(message: "Can't serialize json data.")
                completion(DataManagerRetrivalArrayResult.failure(readingError))
                return
            }
            
            guard let allItems = jsonArray as? [UnboxableDictionary] else {
                let mappingError = DataManagerRetrivalError.mappingError(message: "Can't map the json data.")
                completion(DataManagerRetrivalArrayResult.failure(mappingError))
                return
            }
            
            let unboxedIssueItems: [Venue] = try unbox(dictionaries: allItems)
            completion(DataManagerRetrivalArrayResult.success(unboxedIssueItems))
            
        } catch let error {
            print(error)
            let readingError = DataManagerRetrivalError.jsonDataReadingError(message: error.localizedDescription)
            completion(DataManagerRetrivalArrayResult.failure(readingError))
        }
    }
}
