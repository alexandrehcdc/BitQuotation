import Foundation

public struct Transaction {
    let name: String
    let description: String
    let createdAt: Date
    let nationality: LanguageIdentifierEnum
    let values: [(x: Int, y: Double)]
}
