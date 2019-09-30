import Foundation

protocol QuotationViewContract: class {
    func mountGraphWith(transaction: Transaction, period: Int)
    func redraw(with period: TimeInDaysEnum)
    func startLoading()
    func endLoading()
    func mountCard(transaction: Transaction)
    func mountButtons(selected: TimeInMonthsEnum)
}

protocol QuotationPresenterContract {
    func loadMainQuotation(period: TimeInDaysEnum)
}
