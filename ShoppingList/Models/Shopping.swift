//
//  Shopping.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/27.
//

import Foundation
import RealmSwift


enum PurchaseStatus: String, CaseIterable {
    case unPurchased = "0"
    case purchased = "1"
}

class Shopping: Object, Identifiable, RealmProtocol {

    typealias Model = Shopping
    
    @Persisted(primaryKey: true) var id = ""
    
    @Persisted var itemId: String

    @Persisted var count: Int = 0
    
    @Persisted var purchased: String = PurchaseStatus.unPurchased.rawValue
    
    @Persisted var created_at: String = ""
    
    @Persisted var updated_at: String = ""
    
    @Persisted var purchasedDate: String = ""
    
    var item: Item?
    
    override init() {}
    
    init(itemId: String, count: String, purchased: String) {
        self.itemId = itemId
        self.count = Int(count) ?? 0
        self.purchased = purchased
    }
    
    init(id: String, count: Int) {
        self.id = id
        self.count = count
    }
    
    static func allFetch() throws -> [Shopping] {
        guard let realm = RealmManager.realm else {
            throw ModelError()
        }
        var model = [Shopping]()
        
            realm.objects(Shopping.self).freeze().forEach {
                model.append($0)
        }
        return model
    }
    
    static func fetchList(purchaseStatus: PurchaseStatus) throws -> [Shopping] {
        guard let realm = RealmManager.realm else {
            throw ModelError()
        }
        var model = [Shopping]()
        
        realm.objects(Shopping.self).filter("purchased == '\(String(describing: purchaseStatus.rawValue))'").freeze().forEach {
            model.append($0)
        }
        return model
    }
    
    static func fetch(id: String) throws -> Shopping {
        guard let realm = RealmManager.realm,
              let shopping = realm.object(ofType: Shopping.self, forPrimaryKey: id) else {
            throw ModelError()
        }
        return shopping
    }
    
    static func add(_ model: Shopping) throws {
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
    
    static func update(_ model: Shopping) throws {
        guard let realm = RealmManager.realm else {
            throw ModelError()
        }
        
        do {
            let update = try Shopping.fetch(id: model.id)    
            try realm.write {
                update.count = model.count
                model.updated_at = DateFormatter.stringFromDate(date: Date(), type: .secnd)
            }
        } catch {
            throw ModelError()
        }
    }
    
    
    static func updatePurchaseStatus(id: String, status: Bool) throws {
        guard let realm = RealmManager.realm else {
            throw ModelError()
        }
        
        do {
            let model = try Shopping.fetch(id: id)
            try realm.write {
                model.purchased = status ? PurchaseStatus.purchased.rawValue : PurchaseStatus.unPurchased.rawValue
                model.updated_at = DateFormatter.stringFromDate(date: Date(), type: .secnd)
                model.purchasedDate = status ? DateFormatter.stringFromDate(date: Date(), type: .date) : ""
            }
        } catch {
            throw ModelError()
        }
        
    }
    
    static func delete(_ model: Shopping) throws {
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
