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
    
    /// モデルItemの商品名
    @Persisted var itemName: String = ""
    /// モデルItemの金額
    @Persisted var price: Int  = 0
    
    /// モデルShoppingの個数
    @Persisted var count: Int = 0
    
    /// モデルShoppingのプライマリキー
    @Persisted var shoppingId: String = ""
    
    /// モデルItemのプライマリキー
    @Persisted var itemId: String = ""
    
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
    
    static func add(_ model: PurchasedItem) throws { }
    
    
    static func addItem(shoppingId: String, itemId: String) throws {
        guard let realm = RealmManager.realm,
        let shopping = try? Shopping.fetch(id: shoppingId),
        let item = try? Item.fetch(id: itemId) else {
            throw ModelError()
        }
        let model = PurchasedItem()
        let now = DateFormatter.stringFromDate(date: Date(), type: .secnd)
        
        model.id = UUID().uuidString
        model.itemName = item.name
        model.count = shopping.count
        model.price = item.price
        model.shoppingId = shopping.id
        model.itemId = item.id
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
    
    static func update(_ model: PurchasedItem) throws { }
    
    static func delete(_ model: PurchasedItem) throws { }
    
    static func deleteItem(shoppingId: String) throws {
        guard let realm = RealmManager.realm,
        let shopping = try? Shopping.fetch(id: shoppingId) else {
            throw ModelError()
        }
        let model = realm.objects(PurchasedItem.self).where( { $0.shoppingId == shoppingId })
        
        do {
            try realm.write {
                realm.delete(model)
            }
        } catch {
            throw ModelError()
        }
        
    }
    
    static func allDetele() throws { }
    
}
