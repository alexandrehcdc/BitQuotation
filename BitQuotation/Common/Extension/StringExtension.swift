
import Foundation

extension String {
    
    func uuid() -> String {
        return UUID().uuidString
    }
    
    mutating func setUUID() {
        self = self.uuid()
    }
}
