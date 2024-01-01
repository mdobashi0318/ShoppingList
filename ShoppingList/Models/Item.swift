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
    @Persisted var created_at: String = ""
    @Persisted var updated_at: String = ""
    
    override init() {}
    
    init(name: String, price: String) {
        self.name = name
        self.price = Int(price) ?? 0
    }
    
    init(id: String, name: String, price: String) {
        self.id = id
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
    
    static func add(_ model: Item) throws { 
        guard let realm = RealmManager.realm else {
            throw ModelError()
        }
        
        let now = DateFormatter.stringFromDate(date: Date(), type: .secnd)
        
        model.id = UUID().uuidString
        model.created_at = now
        model.updated_at = now
        
        do {
            try realm.write {
                realm.add(model)
            }
        } catch {
            throw ModelError()
        }
    }
    
    static func addItem(_ model: Item) throws -> String {
        guard let realm = RealmManager.realm else {
            throw ModelError()
        }
        
        let now = DateFormatter.stringFromDate(date: Date(), type: .secnd)
        
        model.id = UUID().uuidString
        model.created_at = now
        model.updated_at = now
        
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
        guard let realm = RealmManager.realm else {
            throw ModelError()
        }
        
        do {
            let update = try Item.fetch(id: model.id)
            try realm.write {
                update.name = model.name
                update.price = model.price
                update.updated_at = DateFormatter.stringFromDate(date: Date(), type: .secnd)
            }
        } catch {
            throw ModelError()
        }
    }
    
    static func delete(_ model: Item) throws {
        
    }
    
    static func allDetele() throws {
        
    }
    
    
    
}
