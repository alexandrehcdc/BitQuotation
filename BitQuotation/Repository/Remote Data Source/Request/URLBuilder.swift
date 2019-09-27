import Foundation

class URLBuilder {
    
    var rootAddress = "https://api.blockchain.info"
    
    func withMarketPrice() -> URLBuilder {
        self.rootAddress += "/charts/market-price?cors=true&format=json"
        
        return self
    }
    
    func with(lang: LanguageIdentifierEnum) -> URLBuilder{
        self.rootAddress += "&lang=\(lang.rawValue)"
        
        return self
    }
    
    func build() -> URL? {
        return URL(string: self.rootAddress)
    }
    
}
