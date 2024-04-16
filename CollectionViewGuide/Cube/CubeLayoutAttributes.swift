import UIKit

class CubeLayoutAttributes: UICollectionViewLayoutAttributes {

    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var layerTransform: CATransform3D = CATransform3DIdentity

    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes = super.copy(with: zone) as! CubeLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.layerTransform = self.layerTransform
        return copiedAttributes
    }

    override func isEqual(_ object: Any?) -> Bool {
        let sup = super.isEqual(object)
        guard let otherAttr = object as? CubeLayoutAttributes else {
            return sup
        }
        return sup
        && self.anchorPoint == otherAttr.anchorPoint
        && CATransform3DEqualToTransform(self.layerTransform, otherAttr.layerTransform)
    }
}

