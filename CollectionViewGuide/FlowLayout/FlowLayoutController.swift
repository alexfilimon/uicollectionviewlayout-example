import UIKit

class FlowLayoutViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Nested Types

    enum Section {
        case first
        case second
        case third
    }
    struct Item: Hashable {
        let title: String
        let color: UIColor
    }

    // MARK: - Properties

    private var collectionView: UICollectionView!
    private var datasource: UICollectionViewDiffableDataSource<Section, Item>!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView.register(FlowCollectionCell.self, forCellWithReuseIdentifier: "cell")

        datasource = .init(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "cell",
                    for: indexPath
                ) as! FlowCollectionCell
                cell.configure(
                    title: itemIdentifier.title,
                    color: itemIdentifier.color
                )
                return cell
            }
        )

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.first, .second, .third])

        let firstSectionColor: UIColor = .systemGreen
        snapshot.appendItems(
            [
                Item(title: "1", color: firstSectionColor),
                Item(title: "2", color: firstSectionColor),
                Item(title: "3", color: firstSectionColor),
                Item(title: "4", color: firstSectionColor),
                Item(title: "5", color: firstSectionColor),
                Item(title: "6", color: firstSectionColor),
                Item(title: "7", color: firstSectionColor),
                Item(title: "8", color: firstSectionColor),
                Item(title: "9", color: firstSectionColor),
                Item(title: "10", color: firstSectionColor),
                Item(title: "11", color: firstSectionColor),
                Item(title: "12", color: firstSectionColor),
                Item(title: "13", color: firstSectionColor),
                Item(title: "14", color: firstSectionColor)
            ],
            toSection: .first
        )

        let secondSectionColor: UIColor = .systemOrange
        snapshot.appendItems(
            [
                Item(title: "1", color: secondSectionColor),
                Item(title: "2", color: secondSectionColor),
                Item(title: "3", color: secondSectionColor)
            ],
            toSection: .second
        )

        let thirdSectionColor: UIColor = .systemBlue
        snapshot.appendItems(
            [
                Item(title: "1", color: thirdSectionColor),
                Item(title: "2", color: thirdSectionColor),
                Item(title: "3", color: thirdSectionColor),
                Item(title: "4", color: thirdSectionColor),
                Item(title: "5", color: thirdSectionColor),
                Item(title: "6", color: thirdSectionColor)
            ],
            toSection: .third
        )

        datasource.apply(snapshot)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let numberOfItems = collectionView.bounds.width > 400 ? 3 : 2
        let spacingBetweenItems: CGFloat = (CGFloat(numberOfItems) - 1) * 10
        let allHSpacing = 20 + spacingBetweenItems
        return .init(
            width: (collectionView.bounds.size.width - allHSpacing) / CGFloat(numberOfItems),
            height: 200
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 5
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }

}

private class FlowCollectionCell: UICollectionViewCell {

    private let titleLabel = UILabel()

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

        contentView.layer.cornerRadius = 10
        contentView.layer.cornerCurve = .continuous
        contentView.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, color: UIColor) {
        titleLabel.text = title
        contentView.backgroundColor = color
    }

}

