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
    
    var errorMessage = ""
    
    init(itemId: String? = nil) {
        if let itemId {
            self.itemId = itemId
            fetch()
        }
    }
    
    func validation() -> Bool {
        if name.isEmpty {
            errorMessage = "商品名が入力されていません"
            errorFlag = true
            return false
        } else if price.isEmpty {
            errorMessage = "金額が入力されていません"
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
                errorMessage = "見つかりません"
                errorFlag = true
            }
            
        }
    }
    
    func add() { }
}
