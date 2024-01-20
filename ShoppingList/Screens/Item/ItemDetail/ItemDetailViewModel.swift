//
//  ItemDetailViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/20.
//

import Foundation


class ItemDetailViewModel: ObservableObject {
    
    private(set) var itemId: String
    
    @Published var model = Item()
    
    @Published var errorFlag = false
    
    var errorMessage = ""
    
    @Published var alertFlag = false
    
    private(set) var alertType: AlertType = .success
    
    private(set) var alertMessage = ""
    
    init(itemId: String) {
        self.itemId = itemId
        fetch()
    }
    
    func fetch() {
        do {
            model = try Item.fetch(id: itemId)
        } catch {
            setAlert(type: .error, message: R.string.label.notFound())
        }
    }
    
    func delete() {
        do {
            try Item.delete(model)
            model = Item()
        } catch {
            setAlert(type: .error, message: R.string.alertMessage.deletionFailed())
        }
    }
    
    func setAlert(type: AlertType, message: String) {
        alertType = type
        alertMessage = message
        alertFlag = true
    }
    
}
