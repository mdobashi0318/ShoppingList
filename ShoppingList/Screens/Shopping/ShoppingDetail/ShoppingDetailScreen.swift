//
//  ShoppingDetailScreen.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/11.
//

import SwiftUI

struct ShoppingDetailScreen: View {
    
    @StateObject var viewModel: ShoppingDetailViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State var isActionSheet = false
    
    @State var isEditScreen = false
    
    var body: some View {
        Form {
            Section {
                ItemDetailView(name: viewModel.item.name,
                               price: viewModel.item.price
                )
                
                
                HStack {
                    Text(R.string.label.quantity())
                    Spacer()
                    Text("\(viewModel.shopping.count)\(R.string.label.pieces())")
                }
            } header: {
                Text(R.string.label.productInformation())
            }
            
            HStack {
                Text(R.string.label.totalAmount())
                Spacer()
                Text("¥\(viewModel.item.price * viewModel.shopping.count)")
            }
            Toggle(R.string.label.alreadyBought(), isOn: $viewModel.purchased)
        }
        .task(id: viewModel.purchased) {
            viewModel.updatePurchaseStatus()
        }
        .navigationTitle(R.string.naviTitle.purchaseDetails())
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                EllipsisButton(action: { isActionSheet.toggle() })
            }
        }
        .confirmationDialog(R.string.alertMessage.whatDoYouWantToDo(), isPresented: $isActionSheet) {
            Button(R.string.button.edit()) {
                isEditScreen.toggle()
            }
            Button(R.string.button.delete(), role: .destructive) {
                viewModel.delete()
                self.dismiss()
            }
        }
        .sheet(isPresented: $isEditScreen) {
            AddShoppingScreen(viewModel: AddShoppingViewModel(mode: .update,
                                                              shoppingId: viewModel.id))
                .onDisappear {
                    viewModel.fetchShopping()
                }
        }
    }
}

#Preview {
    ShoppingDetailScreen(viewModel: ShoppingDetailViewModel(id: ""))
}
