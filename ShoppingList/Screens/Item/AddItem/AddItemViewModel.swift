//
//  AddItemViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/19.
//

import Foundation

@MainActor
class AddItemViewModel: ObservableObject {
    
    @Published private var itemId: String?
    
    @Published var name: String = ""
    
    @Published var price: String = ""
        
    private(set) var mode: Mode = .add
    
    @Published var alertFlag = false
    
    private(set) var alertType: AlertType = .success
    
    private(set) var alertMessage = ""
    
    init(mode: Mode = .add, itemId: String? = nil) {
        self.mode = mode
        if let itemId {
            self.itemId = itemId
            fetch()
        }
    }
    
    func validation() -> Bool {
        if name.isEmpty {
            setAlert(type: .error, message: "商品名が入力されていません")
            return false
        } else if price.isEmpty {
            setAlert(type: .error, message: "金額が入力されていません")
            return false
        }
        return true
    }
    
    
    private func fetch() {
        do {
            guard let itemId else {
                throw ModelError()
            }
            
            let model = try Item.fetch(id: itemId)
            name = model.name
            price = String(model.price)
        } catch {
            Task {
                /// この時点でシートが表示されてないためか、アラートが表示されないため表示フラグを変更するタイミングを遅らせる
                try await Task.sleep(until: .now + .seconds(0.1))
                setAlert(type: .error, message: "見つかりません")
            }
            
        }
    }
    
    func add() { 
        do {
            try Item.add(Item(name: name, price: price))
            setAlert(type: .success, message: "追加しました")
        } catch {
            setAlert(type: .error, message: "追加に失敗しました")
        }
    }
    
    func update() {
        do {
            guard let itemId else {
                throw ModelError()
            }
                        
            try Item.update(Item(id: itemId, name: name, price: price))
            setAlert(type: .success, message: "更新しました")
        } catch {
            setAlert(type: .error, message: "更新に失敗しました")
        }
    }
    
    private func setAlert(type: AlertType, message: String) {
        alertType = type
        alertMessage = message
        alertFlag = true
    }
    
}
