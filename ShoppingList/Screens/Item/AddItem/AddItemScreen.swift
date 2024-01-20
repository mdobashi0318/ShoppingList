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
            .navigationTitle(viewModel.mode == .add ? R.string.naviTitle.addItem() : R.string.naviTitle.updateItem())
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
                    Alert(title: Text(viewModel.alertMessage), dismissButton: .default(Text(R.string.button.close())) {
                        self.dismiss()
                    })
                case .error, .confirm:
                    Alert(title: Text(viewModel.alertMessage), dismissButton: .default(Text(R.string.button.close())))
                }
                
                
            }
        }
    }
}

#Preview {
    AddItemScreen()
}
