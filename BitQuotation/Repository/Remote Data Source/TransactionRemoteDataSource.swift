import Foundation

protocol TransactionRemoteDataSource {
    static func getTransactionalData(lang: LanguageIdentifierEnum, _ responseCallback: @escaping ((Transaction) -> Void))
}
