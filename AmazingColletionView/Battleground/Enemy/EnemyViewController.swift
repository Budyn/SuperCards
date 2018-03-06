// AmazingColletionView
// Created by Daniel Budyński 👾
// MacOS 10.12, Swift 4.0

import UIKit

class EnemyViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let context = ProfileContext.enemy

    private var heroesCount: Int {
        return ProfileList.shared.heroes(for: context).count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dragDelegate = self
        collectionView.dragInteractionEnabled = true
        registeCells()
    }

    func registeCells() {
        let cellNib = UINib(nibName: "HeroCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: HeroCollectionViewCell.reuseID)
    }

    func addEnemyHero() {
        let randomEnemy = HeroesBuilder().generateRandomEnemyHero()
        ProfileList.shared.insert(heroes: [randomEnemy], into: context, at: 0)

        self.collectionView.performBatchUpdates({
            let indexPath = IndexPath(row: 0, section: 0)
            self.collectionView.insertItems(at: [indexPath])
        }, completion: nil)
    }
}

extension EnemyViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroesCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroCollectionViewCell.reuseID, for: indexPath) as! HeroCollectionViewCell
        cell.hero = ProfileList.shared.hero(at: indexPath.row, in: context)
        return cell
    }
}

extension EnemyViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 5, 0, 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

