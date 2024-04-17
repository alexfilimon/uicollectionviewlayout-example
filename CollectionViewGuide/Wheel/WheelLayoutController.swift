import UIKit

class WheelLayoutController: UIViewController, UICollectionViewDataSource {

    // MARK: - Properties

    private var collectionView: UICollectionView!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let wheelLayout = WheelLayout()

        view.backgroundColor = .systemBackground

        collectionView = .init(frame: .zero, collectionViewLayout: wheelLayout)
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                collectionView.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: 0
                ),
                collectionView.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -0
                ),
                collectionView.topAnchor.constraint(
                    equalTo: view.topAnchor,
                    constant: 0
                ),
                collectionView.bottomAnchor.constraint(
                    equalTo: view.bottomAnchor,
                    constant: -0
                )
            ]
        )
        collectionView.layer.masksToBounds = false
//        collectionView.layer.borderColor = UIColor.red.cgColor
//        collectionView.layer.borderWidth = 1

        collectionView.register(WheelCollectionCell.self, forCellWithReuseIdentifier: "cell")
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

    private var wheelLayout: WheelLayout {
        collectionView.collectionViewLayout as! WheelLayout
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2500
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as! WheelCollectionCell
        cell.configure(indexPath: indexPath)
        return cell
    }

}
