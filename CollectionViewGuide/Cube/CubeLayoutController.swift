import UIKit

class CubeLayoutController: UIViewController, UICollectionViewDataSource {

    // MARK: - Properties

    private var collectionView: UICollectionView!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let cubeLayout = CubeFlowLayout()
        cubeLayout.scrollDirection = .horizontal
        cubeLayout.itemSize = UIScreen.main.bounds.size
        cubeLayout.sectionInset = .zero
        cubeLayout.minimumLineSpacing = 0
        cubeLayout.minimumInteritemSpacing = 0

        collectionView = .init(frame: .zero, collectionViewLayout: cubeLayout)
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView.register(CubeCollectionCell.self, forCellWithReuseIdentifier: "cell")
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as! CubeCollectionCell
        cell.configure(indexPath: indexPath)
        return cell
    }

}

