import Foundation

struct TransactionResponse: Codable {
    var name: String?
    var description: String?
    var values: [CoordinateResponse]?
}

struct CoordinateResponse: Codable {
    var x: Int?
    var y: Double?
}
