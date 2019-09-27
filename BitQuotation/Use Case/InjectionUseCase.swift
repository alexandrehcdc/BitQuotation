import Foundation

struct InjectionUseCase {
    static let transactionRemoteDataSource = TransactionRemoteDataSourceImpl()
    
    static func provideTransactionUseCase() -> TransactionUseCase {
        return TransactionUseCase(remoteDataSource: transactionRemoteDataSource)
    }
    
}
