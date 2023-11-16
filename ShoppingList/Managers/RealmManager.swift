//
//  RealmManager.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/24.
//

import Foundation
import RealmSwift





protocol RealmProtocol {
    associatedtype Model
    static func allFetch() throws -> [Model]
    static func fetch(id: String) throws -> Model
    static func add(_ model: Model) throws
    static func update(_ model: Model) throws
    static func delete(_ model: Model) throws
    static func allDetele() throws
}

struct RealmManager {
    
        static let realm: Realm? = {
            var configuration = Realm.Configuration()
            configuration.schemaVersion = UInt64(1)
            guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.masaharu.dobashi.ShoppingList") else { return nil }
            configuration.fileURL = url.appendingPathComponent("db.realm")
            return try? Realm(configuration: configuration)
        }()
        
}



struct ModelError: Error {
    var message = ""
    init(message: String = "") {
        self.message = message
    }
}
