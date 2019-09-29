import Foundation

struct TransactionUseCase {
    let remoteDataSource: TransactionRemoteDataSource
    let localDataSource: TransactionLocalDataSource
    
    func getTransactionDataBy(operation: OperationTypeEnum, _ responseCallback: @escaping ((Transaction) -> Void)) {
        
        switch operation {
        case .local_first:
            guard let transaction = self.localDataSource.findLatest() else {
                getTransactionDataBy(operation: .remote_first, responseCallback)
                return
            }
            
            if (transaction.createdAt.timeIntervalSince1970 + 86400) > Date().timeIntervalSince1970 {
                responseCallback(transaction)
                return
            }
            getTransactionDataBy(operation: .remote_first, responseCallback)
        case .remote_first:
            self.remoteDataSource.getTransactionalData(lang: .en) { (response) in

                DispatchQueue.main.async {
                    guard let transaction = self.localDataSource.save(transaction: response) else { return }
                    
                    responseCallback(transaction)
                }
            }
        case .remote_only:
            self.remoteDataSource.getTransactionalData(lang: .en) { (response) in
                responseCallback(response)
            }
        case .local_only:
            guard let transaction = self.localDataSource.findLatest() else { return }
            responseCallback(transaction)
        }
        
    }
}
