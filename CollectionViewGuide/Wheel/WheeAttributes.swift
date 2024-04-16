import UIKit

class WheelLayoutAttributes: UICollectionViewLayoutAttributes {

    // MARK: - Properties

    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var isInside: Bool = true

    // MARK: - NSObject

    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes: WheelLayoutAttributes = super.copy(with: zone) as! WheelLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.isInside = isInside
        return copiedAttributes
    }

    override func isEqual(_ object: Any?) -> Bool {
        let sup = super.isEqual(object)
        guard let otherAttr = object as? WheelLayoutAttributes else {
            return sup
        }
        return sup
        && self.anchorPoint == otherAttr.anchorPoint
        && self.isInside == otherAttr.isInside
    }

}

