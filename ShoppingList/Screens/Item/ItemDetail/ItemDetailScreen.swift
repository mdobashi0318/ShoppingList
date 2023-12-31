//
//  ItemDetailScreen.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/20.
//

import SwiftUI

struct ItemDetailScreen: View {
    
    @StateObject var viewModel: ItemDetailViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State var isActionSheet = false
    
    @State var isEditScreen = false
    
    var body: some View {
        Form {
            ItemDetailView(name: viewModel.model.name,
                           price: viewModel.model.price
            )
        }
        .navigationTitle(R.string.naviTitle.itemDetails())
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                EllipsisButton(action: { isActionSheet.toggle() })
            }
        }
        .confirmationDialog("どうしますか？", isPresented: $isActionSheet) {
            Button("編集") {
                isEditScreen.toggle()
            }
            Button("削除", role: .destructive) {
                viewModel.delete()
                self.dismiss()
            }
        }
        .sheet(isPresented: $isEditScreen) {
            AddItemScreen(viewModel: AddItemViewModel(mode: .update,
                                                      itemId: viewModel.itemId)
            )
                .onDisappear {
                    viewModel.fetch()
                }
        }
        .alert(isPresented: $viewModel.errorFlag) {
            Alert(title: Text(viewModel.errorMessage), dismissButton: .default(Text("閉じる")))
        }

    }
}

#Preview {
    ItemDetailScreen(viewModel: ItemDetailViewModel(itemId: ""))
}
