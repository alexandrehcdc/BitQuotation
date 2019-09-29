import Foundation

struct QuotationPresenter: QuotationPresenterContract {
    
    let transactionUseCase: TransactionUseCase = InjectionUseCase.provideTransactionUseCase()
    unowned var view: QuotationViewContract
    
    func loadMainQuotation(period: TimeInDaysEnum) {
        self.view.startLoading()
        transactionUseCase.getTransactionDataBy(operation: .local_first) { transaction in
            self.view.mountGraphWith(transaction: transaction,
                                     period: period.rawValue)
            
            self.view.endLoading()
        }
    }
    
}
