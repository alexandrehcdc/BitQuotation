import Foundation

protocol TransactionRemoteDataSource {
    func getTransactionalData(lang: LanguageIdentifierEnum, _ responseCallback: @escaping ((Transaction) -> Void))
}
