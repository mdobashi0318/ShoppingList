//
//  AddItemScreen.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/19.
//

import SwiftUI

struct AddItemScreen: View {
    
    @StateObject var viewModel = AddItemViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                ItemAddFormView(name: $viewModel.name,
                                price: $viewModel.price
                )
            }
            .navigationTitle("アイテム追加")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    AddButton {
                        if viewModel.validation() {
                            if viewModel.mode == .add {
                                viewModel.add()
                            } else {
                                viewModel.update()
                            }
                        }
                    }
                }
            }
            .alert(isPresented: $viewModel.alertFlag) {
                switch viewModel.alertType {
                case .success:
                    Alert(title: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")) {
                        self.dismiss()
                    })
                case .error:
                    Alert(title: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
                }
                
                
            }
        }
    }
}

#Preview {
    AddItemScreen()
}
