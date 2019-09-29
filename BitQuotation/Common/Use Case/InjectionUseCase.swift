import RealmSwift

struct InjectionUseCase {
    
    static private let realm = try! Realm()
    
    static private let transactionRemoteDataSource = TransactionRemoteDataSourceImpl()
    
    static func provideTransactionUseCase() -> TransactionUseCase {
        return TransactionUseCase(remoteDataSource: transactionRemoteDataSource,
                                  localDataSource: InjectionUseCase.provideTransactionLocalDataSource())
    }
    
    static func provideTransactionLocalDataSource() -> TransactionLocalDataSource {
        return TransactionLocalDataSourceImpl(realm: realm)
    }
    
}
