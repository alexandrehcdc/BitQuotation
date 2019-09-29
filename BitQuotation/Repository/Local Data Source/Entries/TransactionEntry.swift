import RealmSwift

public class TransactionEntry: Object {
    
    @objc dynamic var id                   = String().uuid(),
                      name                 = String(),
                      quotationDescription = String(),
                      nationality          = String(),
                      createdAt            = Date()
    
    let timestamp      = List<Int>(),
        quotationValue = List<Double>()
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}
