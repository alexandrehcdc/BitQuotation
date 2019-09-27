import Foundation

struct Transaction {
    let name: String
    let description: String
    let values: [(x: Int, y: Double)]
    
    static func buildFrom(response: TransactionResponse) -> Transaction {
        guard let coordinates = response.values else { return Transaction(name: String(),
                                                                          description: String(),
                                                                          values: []) }
        
        return Transaction(name: response.name ?? String(),
                           description: response.name ?? String(),
                           values: coordinates.map { (x: $0.x, y: $0.y) } )
    }
}
