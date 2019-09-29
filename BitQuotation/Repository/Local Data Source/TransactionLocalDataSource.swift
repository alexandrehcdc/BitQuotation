
import Foundation

public protocol TransactionLocalDataSource {
    func save(transaction: Transaction) -> Transaction?
    func findLatest() -> Transaction?
}
