//
//  PurchasedDetailScreen.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2024/02/06.
//

import SwiftUI

struct PurchasedDetailScreen: View {
    
    @StateObject var viewModel: PurchasedDetailViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State var isActionSheet = false
    
    var body: some View {
        ShoppingDetailView(name: viewModel.purchasedItem.itemName,
                           price: viewModel.purchasedItem.price,
                           itemCount: viewModel.purchasedItem.count,
                           toggleValue: $viewModel.purchased,
                           toggleAction: { _ in },
                           isToggleDisp: false
        )
        .navigationTitle(R.string.naviTitle.purchaseDetails())
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                EllipsisButton(action: { isActionSheet.toggle() })
            }
        }
        .confirmationDialog(R.string.alertMessage.whatDoYouWantToDo(), isPresented: $isActionSheet) {
            Button(R.string.button.delete(), role: .destructive) {
                viewModel.setAlert(type: .confirm, message: R.string.alertMessage.deleteConfirm())
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

