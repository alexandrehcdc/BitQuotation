import Foundation

protocol QuotationViewContract: class {
    func mountGraphWith(transaction: Transaction)
}

protocol QuotationPresenterContract {
    func loadMainQuotation()
}
