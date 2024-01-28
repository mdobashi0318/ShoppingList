//
//  Purchased.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2024/01/25.
//

import Foundation
import RealmSwift

class PurchasedItem: Object, Identifiable, RealmProtocol {
    
    typealias Model = PurchasedItem
    
    @Persisted(primaryKey: true) var id: String = ""
    
    @Persisted var itemName: String = ""
    @Persisted var price: Int  = 0
    @Persisted var count: Int = 0
    @Persisted var purchased: String = PurchaseStatus.unPurchased.rawValue
    @Persisted var created_at: String = ""
    @Persisted var updated_at: String = ""
    
    
    static func allFetch() throws -> [PurchasedItem] {
        guard let realm = RealmManager.realm else {
            throw ModelError()
        }
        var model = [PurchasedItem]()
        realm.objects(PurchasedItem.self).freeze().forEach { model.append($0) }
        return model
    }
    
    static func fetch(id: String) throws -> PurchasedItem {
        guard let realm = RealmManager.realm,
              let model = realm.object(ofType: PurchasedItem.self, forPrimaryKey: id) else  {
            throw ModelError()
        }
        return model
    }
    
    static func add(_ model: PurchasedItem) throws {
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
    
    static func update(_ model: PurchasedItem) throws {
        guard let realm = RealmManager.realm else {
            throw ModelError()
        }
        
        do {
            let update = try PurchasedItem.fetch(id: model.id)
            try realm.write {
                update.count = model.count
                model.updated_at = DateFormatter.stringFromDate(date: Date(), type: .secnd)
            }
        } catch {
            throw ModelError()
        }
    }
    
    static func delete(_ model: PurchasedItem) throws {
        guard let realm = RealmManager.realm else {
            throw ModelError()
        }
        
        do {
            try realm.write {
                realm.delete(model)
            }
        } catch {
            throw ModelError()
        }
    }
    
    static func allDetele() throws {
        
    }
    
    
    
    
}
