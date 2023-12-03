//
//  AddItemViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/19.
//

import Foundation

@MainActor
class AddItemViewModel: ObservableObject {
    
    @Published var itemId: String?
    
    @Published var name: String = ""
    
    @Published var price: String = ""
    
    @Published var errorFlag = false
    
    @Published var successFlag = false
    
    private(set) var alertMessage = ""
    
    private(set) var mode: Mode = .add
    
    init(mode: Mode = .add, itemId: String? = nil) {
        self.mode = mode
        if let itemId {
            self.itemId = itemId
            fetch()
        }
    }
    
    func validation() -> Bool {
        if name.isEmpty {
            alertMessage = "商品名が入力されていません"
            errorFlag = true
            return false
        } else if price.isEmpty {
            alertMessage = "金額が入力されていません"
            errorFlag = true
            return false
        }
        
        errorFlag = false
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
                alertMessage = "見つかりません"
                errorFlag = true
            }
            
        }
    }
    
    func add() { 
        do {
            try Item.add(Item(name: name, price: price))
            alertMessage = "追加しました"
            successFlag = true
        } catch {
            alertMessage = "追加に失敗しました"
            errorFlag = true
        }
    }
    
    func update() {
        do {
            guard let itemId else {
                throw ModelError()
            }
                        
            try Item.update(Item(id: itemId, name: name, price: price))
            alertMessage = "更新しました"
            successFlag = true
        } catch {
            alertMessage = "更新に失敗しました"
            errorFlag = true
        }
    }
}
