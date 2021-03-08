//
//  Users.swift
//  RandomUser
//
//  Created by Chris Harding on 3/5/21.
//

import Foundation

struct Users: Codable {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    static func savetoFile (users:[Users]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedUser = try? propertyListEncoder.encode(users)
        
        do {
            try encodedUser?.write(to: archiveURL, options: .noFileProtection)
        } catch {
            print(error)
        }
        
    }
    static func loadFromFile() -> [Users] {
        var newUser : [Users] = []
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedUserData = try? Data(contentsOf: archiveURL), let decodedUser = try? propertyListDecoder.decode([Users].self, from: retrievedUserData) {
           
            newUser = decodedUser        }
        
        return newUser
    }

}

var documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
var archiveURL = documentDirectory.appendingPathComponent("users.Plist")
