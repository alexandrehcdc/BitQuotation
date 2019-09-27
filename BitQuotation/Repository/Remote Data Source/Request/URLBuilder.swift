import Foundation

struct URLBuilder {
    
    var rootAddress = "https://api.blockchain.info"
    
    func withMarketPrice() -> URLBuilder {
        var builder = URLBuilder()
        
        builder.rootAddress += "/market-price?cors=true&format=json"
        
        return builder
    }
    
    func with(lang: LanguageIdentifierEnum) -> URLBuilder{
        var builder = URLBuilder()
        
        builder.rootAddress += lang.rawValue
        
        return builder
    }
    
    func build() -> URL? {
        return URL(string: self.rootAddress)
    }
    
}
