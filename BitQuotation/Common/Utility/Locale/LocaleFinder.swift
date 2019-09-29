
import Foundation

struct LocaleFinder {
    
    static func getLocaleEnum() -> LanguageIdentifierEnum {
        let locale = Locale.current.description
        
        if locale.hasPrefix("en") {
            return .en
        } else if locale.hasPrefix("es") {
            return .es
        } else if locale.hasPrefix("pt") {
            return .pt
        } else {
            return .none
        }
    }
    
}
