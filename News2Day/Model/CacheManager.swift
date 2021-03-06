//
//  CacheManager.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/02/26.
//

import Foundation


class CacheManager {
    
    static var imageDictionary = [String: Data]()
    
    static func saveData(forURL url: String, imageData: Data) {
        imageDictionary[url] = imageData
    }
    static func retrieveData (forURL url: String) -> Data? {
        
        return imageDictionary[url]
    }
    
}
