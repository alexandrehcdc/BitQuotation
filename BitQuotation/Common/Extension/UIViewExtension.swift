
import UIKit

extension UIView {
    func removeSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views { self.addSubview(view) }
    }
}
