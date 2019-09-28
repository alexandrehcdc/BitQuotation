import Foundation

struct QuotationPresenter: QuotationPresenterContract {
    
    let transactionUseCase: TransactionUseCase = InjectionUseCase.provideTransactionUseCase()
    unowned var view: QuotationViewContract
    
    func loadMainQuotation() {
        transactionUseCase.getTransactionDataBy(operation: .remote_only) { transaction in
            self.view.mountGraphWith(transaction: transaction)
        }
    }
    
}
