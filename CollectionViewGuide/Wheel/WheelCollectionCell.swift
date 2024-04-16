import UIKit

class WheelCollectionCell: UICollectionViewCell {

    // MARK: - Properties

    private let titleLabel = UILabel()
    private let allColors: [UIColor] = [.systemRed, .systemGreen]

    private var savedColor: UIColor = .black
    private var isInside: Bool = true

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UICollectionViewCell

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        let wheelAttr = layoutAttributes as! WheelLayoutAttributes

        self.layer.anchorPoint = wheelAttr.anchorPoint
        self.center.y += (wheelAttr.anchorPoint.y - 0.5) * self.bounds.height

        self.isInside = wheelAttr.isInside
        self.contentView.backgroundColor = wheelAttr.isInside ? savedColor : .black
    }

    // MARK: - Configuration

    func configure(indexPath: IndexPath) {
        titleLabel.text = indexPath.description
        let colorIndex = indexPath.row
        savedColor = allColors[colorIndex % 2]
        contentView.backgroundColor = isInside ? savedColor : .black
    }

}
