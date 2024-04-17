import UIKit

class CompositionalLayoutController: UIViewController {

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

        let layout = UICollectionViewCompositionalLayout { sectionIndex, env in
            let width = env.container.effectiveContentSize.width
            let numberOfItemsToRepeat = width > 400 ? 3 : 2

            let topRightHGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(0.5)
                ),
                repeatingSubitem: .init(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1 / CGFloat(numberOfItemsToRepeat)),
                        heightDimension: .fractionalHeight(1)
                    )
                ),
                count: numberOfItemsToRepeat
            )
            topRightHGroup.interItemSpacing = .fixed(10)
            let topRightGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)),
                subitems: [
                    topRightHGroup
                ]
            )
            topRightGroup.interItemSpacing = .fixed(10)
            let topLeftItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1)
                )
            )
            let topGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(0.5)
                ),
                subitems: [
                    topLeftItem,
                    topRightGroup
                ]
            )
            topGroup.interItemSpacing = .fixed(10)
            let bottomGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(0.5)
                ),
                subitems: [
                    topRightGroup,
                    topLeftItem
                ]
            )
            bottomGroup.interItemSpacing = .fixed(10)
            let vGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(400)
                ),
                subitems: [
                    topGroup,
                    bottomGroup
                ]
            )

            vGroup.interItemSpacing = .fixed(10)
            vGroup.edgeSpacing = .init(
                leading: .fixed(0),
                top: .fixed(0),
                trailing: .fixed(0),
                bottom: .fixed(10)
            )
            let section = NSCollectionLayoutSection(
                group: vGroup
            )
            section.contentInsets = .init(
                top: 20,
                leading: 10,
                bottom: 20,
                trailing: 10
            )
            return section
        }

        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView.register(CompositionalCollectionCell.self, forCellWithReuseIdentifier: "cell")

        datasource = .init(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "cell",
                    for: indexPath
                ) as! CompositionalCollectionCell
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

}

private class CompositionalCollectionCell: UICollectionViewCell {

    // MARK: - Properties

    private let titleLabel = UILabel()

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

        contentView.layer.cornerRadius = 10
        contentView.layer.cornerCurve = .continuous
        contentView.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(title: String, color: UIColor) {
        titleLabel.text = title
        contentView.backgroundColor = color
    }

}
