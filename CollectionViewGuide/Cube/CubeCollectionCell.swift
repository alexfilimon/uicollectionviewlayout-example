import UIKit

class CubeCollectionCell: UICollectionViewCell {

    // MARK: - Properties

    private let titleLabel = UILabel()
    private var coloredBackgroundView = UIView()

    private let allColors: [UIColor] = [.systemRed, .systemGreen]

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(coloredBackgroundView)
        coloredBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        coloredBackgroundView.layer.zPosition = 100
        NSLayoutConstraint.activate([
            coloredBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coloredBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coloredBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coloredBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        coloredBackgroundView.layer.cornerRadius = 44
        coloredBackgroundView.layer.cornerCurve = .continuous
        coloredBackgroundView.layer.masksToBounds = true

        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.layer.zPosition = 1000
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UICollectionViewCell

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        let customAttributes = layoutAttributes as! CubeLayoutAttributes

        contentView.transform3D = customAttributes.layerTransform

        contentView.center.x = (customAttributes.anchorPoint.x) * self.bounds.width
        contentView.layer.anchorPoint = customAttributes.anchorPoint
    }

    // MARK: - Methods

    func configure(indexPath: IndexPath) {
        titleLabel.text = indexPath.description
        let colorIndex = indexPath.row
        coloredBackgroundView.backgroundColor = allColors[colorIndex % 2]
    }

}
