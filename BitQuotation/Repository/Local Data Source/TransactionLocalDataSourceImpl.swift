
import RealmSwift

struct TransactionLocalDataSourceImpl: TransactionLocalDataSource {
    
    unowned var realm: Realm
    
    func save(transaction: Transaction) -> Transaction? {
        
        let entry = TransactionConverter.asEntry(entity: transaction)
        
        do {
            try realm.write {
                if entry.id == "" {
                    entry.id.setUUID()
                }
                realm.add(entry, update: true)
            }
        } catch let error as NSError {
            print("Unexpected error: \(error.debugDescription)")
            return nil
        }
        
        return transaction
    }
    
    func findLatest() -> Transaction? {
        guard let result = realm.objects(TransactionEntry.self).sorted(byKeyPath: "createdAt", ascending: false).first else { return nil }
        
        return TransactionConverter.asEntity(entry: result)
    }
    
}
