import UIKit

class WheelLayout: UICollectionViewLayout {

    // MARK: - Properties

    let itemSize: CGSize = .init(width: 100, height: 200)
    let radius: CGFloat = 500

    private var anglePerItem: CGFloat {
        atan((itemSize.width / 2) / (radius - itemSize.height / 2)) * 2
    }

    private var cachedAttributes: [WheelLayoutAttributes] = []

    private var lastItemAngle: CGFloat {
        guard collectionView!.numberOfItems(inSection: 0) > 0 else {
            return 0
        }
        let lastItemIndex = collectionView!.numberOfItems(inSection: 0) - 1
        return -CGFloat(lastItemIndex) * anglePerItem
    }
    private var angle: CGFloat {
        let contentWidthWithoutViewPort = collectionViewContentSize.width - collectionView!.bounds.width
        return lastItemAngle * collectionView!.contentOffset.x / contentWidthWithoutViewPort
    }

    var angleForSkip: CGFloat {
        atan((collectionView!.bounds.width / 2) / (radius - collectionView!.bounds.height / 2)) + anglePerItem / 2
    }

    // MARK: - UICollectionViewLayout Properties

    override var collectionViewContentSize: CGSize {
        let numberOfItems: Int = {
            if collectionView!.numberOfSections > 0 {
                return collectionView!.numberOfItems(inSection: 0)
            }
            return 0
        }()
        return .init(
            width: CGFloat(numberOfItems) * itemSize.width,
            height: collectionView!.bounds.height
        )
    }

    override class var layoutAttributesClass: AnyClass {
        WheelLayoutAttributes.self
    }

    private var cachedStartIndex: Int = 0

    // MARK: - UICollectionViewLayout Methods

    override func prepare() {
        super.prepare()

        let centerX = collectionView!.contentOffset.x + (collectionView!.bounds.width / 2)

        guard collectionView!.numberOfSections > 0 else { return }

        let startIndex: Int = {
            if (angle < -angleForSkip) {
                return Int(floor((-angleForSkip - angle) / anglePerItem)) + 1
            }
            return 0
        }()
        let endIndex: Int = {
            let lastElementIndex = collectionView!.numberOfItems(inSection: 0) - 1
            return min(lastElementIndex, Int(ceil((angleForSkip - angle) / anglePerItem)) - 1)
        }()

        cachedStartIndex = startIndex

        cachedAttributes = (startIndex...endIndex).map {
            let attributes = WheelLayoutAttributes(
                forCellWith: IndexPath(item: $0, section: 0)
            )

            attributes.size = itemSize
            attributes.center = CGPoint(
                x: centerX,
                y: collectionView!.bounds.midY
            )
            let curAngle = angle + self.anglePerItem * CGFloat($0)
            attributes.transform = CGAffineTransformMakeRotation(curAngle)

            let anchorPointY = (itemSize.height / 2 + radius) / itemSize.height
            attributes.anchorPoint = .init(x: 0.5, y: anchorPointY)

            attributes.isInside = $0 >= startIndex && $0 <= endIndex

            return attributes
        }
    }

    override func layoutAttributesForItem(
        at indexPath: IndexPath
    ) -> UICollectionViewLayoutAttributes? {
        let currentIndex = indexPath.row - cachedStartIndex
        if currentIndex < 0 || currentIndex >= cachedAttributes.count {
            return nil
        }
        return cachedAttributes[currentIndex]
    }

    override func layoutAttributesForElements(
        in rect: CGRect
    ) -> [UICollectionViewLayoutAttributes]? {
        return cachedAttributes
    }

    override func shouldInvalidateLayout(
        forBoundsChange newBounds: CGRect
    ) -> Bool {
        return true
    }

    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        let contentWidthWithoutViewPort = collectionViewContentSize.width - collectionView!.bounds.width
        let factor = -lastItemAngle / contentWidthWithoutViewPort
        let proposedAngle = proposedContentOffset.x * factor
        let proposedItemIndex = proposedAngle / anglePerItem

        let nextSelectedItemIndex: CGFloat = {
            if (velocity.x > 0) {
                return ceil(proposedItemIndex)
            } else if (velocity.x < 0) {
                return floor(proposedItemIndex)
            } else {
                return round(proposedItemIndex)
            }
        }()

        return CGPoint(
            x: nextSelectedItemIndex * anglePerItem / factor,
            y: proposedContentOffset.y
        )
    }

}
