//
//  Item.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/24.
//

import Foundation
import RealmSwift

class Item: Object, Identifiable, RealmProtocol {
    
    typealias Model = Item
    
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var name: String = ""
    @Persisted var price: Int  = 0
    
    override init() {}
    
    init(name: String, price: String) {
        self.name = name
        self.price = Int(price) ?? 0
    }
    
    static func allFetch() throws -> [Item] {
        guard let realm = RealmManager.realm else {
            throw ModelError()
        }
        var model = [Item]()
        realm.objects(Item.self).freeze().forEach { model.append($0) }
        return model
    }
    
    
    static func fetch(id: String) throws -> Item {
        guard let realm = RealmManager.realm,
              let item = realm.object(ofType: Item.self, forPrimaryKey: id) else  {
            throw ModelError()
        }
        return item
    }
    
    static func add(_ model: Item) throws { }
    
    static func addItem(_ model: Item) throws -> String {
        guard let realm = RealmManager.realm else {
            throw ModelError()
        }
        
        model.id = UUID().uuidString
        
        do {
            try realm.write {
                realm.add(model)
            }
            return model.id
        } catch {
            throw ModelError()
        }
    }
    
    static func update(_ model: Item) throws {
        
    }
    
    static func delete(_ model: Item) throws {
        
    }
    
    static func allDetele() throws {
        
    }
    
    
    
}
