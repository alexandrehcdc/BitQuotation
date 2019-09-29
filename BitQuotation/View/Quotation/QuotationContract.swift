import Foundation

protocol QuotationViewContract: class {
    func mountGraphWith(transaction: Transaction, period: Int)
    func redraw(with period: TimeEnum)
    func startLoading()
    func endLoading()
    func mountCard()
    func mountButtons()
}

protocol QuotationPresenterContract {
    func loadMainQuotation(period: TimeEnum)
}
