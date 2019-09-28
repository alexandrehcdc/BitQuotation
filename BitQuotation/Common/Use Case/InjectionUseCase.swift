import Foundation

struct InjectionUseCase {
    static private let transactionRemoteDataSource = TransactionRemoteDataSourceImpl()
    
    static func provideTransactionUseCase() -> TransactionUseCase {
        return TransactionUseCase(remoteDataSource: transactionRemoteDataSource)
    }
    
}
