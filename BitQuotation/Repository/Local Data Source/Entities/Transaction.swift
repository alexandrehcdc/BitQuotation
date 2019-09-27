import Foundation

struct Transaction {
    let name: String
    let description: String
    let values: [(x: Int, y: Double)]
    
    static func buildFrom(response: TransactionResponse) -> Transaction {
        guard let coordinates = response.values else { return Transaction(name: String(),
                                                                          description: String(),
                                                                          values: []) }
        
        let validCoordinates = coordinates.map { (teste) -> (x: Int, y: Double) in
            return (x: teste.x ?? 0, y: teste.y ?? 0)
        }
        
        return Transaction(name: response.name ?? String(),
                           description: response.name ?? String(),
                           values: validCoordinates )
    }
}
