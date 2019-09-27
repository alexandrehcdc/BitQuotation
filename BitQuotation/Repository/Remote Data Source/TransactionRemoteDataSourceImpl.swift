import Foundation

struct TransactionRemoteDataSourceImpl: TransactionRemoteDataSource {
    
    func getTransactionalData(lang: LanguageIdentifierEnum, _ responseCallback: @escaping ((Transaction) -> Void)) {
        
        let url = URLBuilder()
                      .withMarketPrice()
                      .with(lang: lang)
                      .build()
        
        guard let validURL = url else { return }
        
        GenericRequest
            .simpleGetWith(url: validURL) { (response: TransactionResponse) in
                
            let entity = Transaction.buildFrom(response: response)
                
            responseCallback(entity)
        }
    }
    
}
