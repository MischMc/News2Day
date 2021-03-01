//
//  CacheManager.swift
//  News2Day
//
//  Created by Misch McNamara on 2021/02/26.
//

import Foundation


class CacheManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveData(_ url:String, _ imageData:Data) {
         
        // Save the image data along with URL
        imageDictionary[url] = imageData
 }
    static func retrieveData (_ url:String) -> Data? {
        
        //return saved image data or Nil
        return imageDictionary[url]
    }
    
}