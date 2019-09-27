import Foundation

struct TransactionUseCase {
    let remoteDataSource: TransactionRemoteDataSource
    
    func getTransactionDataBy(operation: OperationTypeEnum, _ responseCallback: @escaping ((Transaction) -> Void)) {
        
        switch operation {
        case .remote_only:
            self.remoteDataSource.getTransactionalData(lang: .en) { (response) in
                responseCallback(response)
            }
        default:
            print("to do")
        }
        
    }
}
