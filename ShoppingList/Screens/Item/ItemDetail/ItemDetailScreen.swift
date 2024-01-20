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
        .confirmationDialog(R.string.alertMessage.whatDoYouWantToDo(), isPresented: $isActionSheet) {
            Button(R.string.button.edit()) {
                isEditScreen.toggle()
            }
            Button(R.string.button.delete(), role: .destructive) {
                viewModel.setAlert(type: .confirm, message: R.string.alertMessage.deleteConfirm())
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
        .alert(isPresented: $viewModel.alertFlag) {
            switch viewModel.alertType {
            case .success:
                Alert(title: Text(viewModel.alertMessage),
                      dismissButton: .default(Text(R.string.button.close()),
                                              action: { dismiss() }
                                             )
                )
            case .error:
                Alert(title: Text(viewModel.alertMessage),
                      dismissButton: .default(Text(R.string.button.close()))
                )
            case .confirm:
                Alert(title: Text(viewModel.alertMessage), primaryButton: .destructive(Text(R.string.button.delete()), action: {
                    Task {
                        viewModel.delete()
                        viewModel.setAlert(type: .success, message: R.string.alertMessage.deleted())
                    }
                }),
                      secondaryButton: .cancel(Text(R.string.button.cancel()))
                )
            }
        }

    }
}

#Preview {
    ItemDetailScreen(viewModel: ItemDetailViewModel(itemId: ""))
}
