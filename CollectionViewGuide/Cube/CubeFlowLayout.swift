import UIKit

class CubeFlowLayout: UICollectionViewFlowLayout {

    override class var layoutAttributesClass: AnyClass {
        CubeLayoutAttributes.self
    }

    override func layoutAttributesForElements(
        in rect: CGRect
    ) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        return attributes
            .map { self.transformLayoutAttributes($0.copy() as! CubeLayoutAttributes) }
    }

    override func shouldInvalidateLayout(
        forBoundsChange newBounds: CGRect
    ) -> Bool {
        return true
    }

    private func transformLayoutAttributes(
        _ attributes: CubeLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }

        let distance = collectionView.frame.width
        let itemOffset = attributes.center.x - collectionView.contentOffset.x
        let middleOffset = itemOffset / distance - 0.5

        if abs(middleOffset) >= 1 {
            attributes.transform3D = CATransform3DIdentity
            attributes.anchorPoint = .init(x: 0.5, y: 0.5)
        } else {
            let rotateAngle = .pi / 2 * middleOffset
            let anchorPoint = CGPoint(x: middleOffset > 0 ? 0 : 1, y: 0.5)

            var transform = CATransform3DIdentity
            transform.m34 = -1 / 500
            transform = CATransform3DRotate(transform, rotateAngle, 0, 1, 0)

            attributes.layerTransform = transform
            attributes.anchorPoint = anchorPoint
        }

        return attributes
    }

}
