// AmazingColletionView
// Created by Daniel Budyński 👾
// MacOS 10.12, Swift 4.0

import UIKit

class BattlegroundViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var controlCenterView: UIView!
    
    let context = ProfileContext.battleground
    var grid = GridObject.defaultGrid(1000)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dropDelegate = self
        collectionView.clipsToBounds = true
        registerCells()
    }

    func registerCells() {
        let heroCellNib = UINib(nibName: "HeroCollectionViewCell", bundle: nil)
        let gridCellNib = UINib(nibName: "GridCellCollectionViewCell", bundle: nil)
        collectionView.register(heroCellNib, forCellWithReuseIdentifier: HeroCollectionViewCell.reuseID)
        collectionView.register(gridCellNib, forCellWithReuseIdentifier: GridCellCollectionViewCell.reuseID)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func reloadButtonTapped(_ sender: UIButton) {
        grid = GridObject.defaultGrid(1000)
        collectionView.performBatchUpdates({
            self.collectionView.reloadSections(IndexSet(integersIn: 0..<self.collectionView.numberOfSections))
        }, completion: nil)
    }

    @IBAction func enemyButtonTapped(_ sender: UIButton) {
        childViewControllers.forEach {
            guard let enemyVC = $0 as? EnemyViewController else { return }
            enemyVC.addEnemyHero()
        }
    }

    @IBAction func supportButtonTapped(_ sender: UIButton) {
        childViewControllers.forEach {
            guard let playerVC  = $0 as? PlayerViewController else { return }
            playerVC.addSupplyHero()
        }
    }
}
extension BattlegroundViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return grid.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let hero = grid[indexPath.row].hero else {
           return collectionView.dequeueReusableCell(withReuseIdentifier: GridCellCollectionViewCell.reuseID, for: indexPath) as! GridCellCollectionViewCell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroCollectionViewCell.reuseID, for: indexPath) as! HeroCollectionViewCell
        cell.context = context
        cell.hero = hero
        return cell
    }
}

extension BattlegroundViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 57, height: 89)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
