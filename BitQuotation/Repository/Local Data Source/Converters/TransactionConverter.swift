
import Foundation

public struct TransactionConverter {
    
    static func asEntry(entity: Transaction) -> TransactionEntry {
        let entry = TransactionEntry()
        
        entry.createdAt = Date()
        entry.name = entity.name
        entry.nationality = entity.nationality.rawValue
        entry.quotationDescription = entity.description
        
        for (x,y) in entity.values {
            entry.timestamp.append(x)
            entry.quotationValue.append(y)
        }
        
        return entry
    }
    
    static func asEntity(entry: TransactionEntry) -> Transaction {
        
        var values: [(x: Int, y: Double)] = []
        
        for index in 0...entry.timestamp.count - 1 {
           values.append((x: entry.timestamp[index],
                          y: entry.quotationValue[index]))
        }
        
        return Transaction(name: entry.name,
                           description: entry.quotationDescription,
                           createdAt: entry.createdAt,
                           nationality: LanguageIdentifierEnum(rawValue: entry.nationality) ?? .none,
                           values: values)
    }
    
    static func asEntity(from response: TransactionResponse) -> Transaction {
        guard let coordinates = response.values else { return Transaction(name: String(),
                                                                          description: String(),
                                                                          createdAt: Date(),
                                                                          nationality: .none,
                                                                          values: []) }
        
        return Transaction(name: response.name ?? String(),
                           description: response.name ?? String(),
                           createdAt: Date(),
                           nationality: LocaleFinder.getLocaleEnum(),
                           values: coordinates.map { (x: $0.x ?? 0, y: $0.y ?? 0) } )
    }
    
}
