// AmazingColletionView
// Created by Daniel Budyński 👾
// MacOS 10.12, Swift 4.0

import UIKit

extension BattlegroundViewController: UICollectionViewDropDelegate {

    func collectionView(_ collectionView: UICollectionView, dropPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let parameters = UIDragPreviewParameters()
        parameters.backgroundColor = .clear
        return parameters
    }

    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard
            let dragCoordinator = coordinator.session.localDragSession?.localContext as? DragCoordinator,
            let firstItemDropDestination = coordinator.destinationIndexPath
        else { return }

        dragCoordinator.calculateDestinationIndexPaths(from: firstItemDropDestination, count: coordinator.items.count)
        dragCoordinator.destinationContext = context

        dropHero(with: dragCoordinator, dropCoordinator: coordinator)
    }

    private func dropHero(with dragCoordinator: DragCoordinator, dropCoordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPaths = dragCoordinator.destinationIndexPaths else { return }

        let sourceItems = dragCoordinator.sourceIndexPaths.map { return $0.item }
        let sourceHeroes = ProfileList.shared.deleteHeroes(at: sourceItems, in: dragCoordinator.sourceContext)

        dropCoordinator.items.enumerated()
            .map { ($1.dragItem, sourceHeroes[$0], destinationIndexPaths[$0]) }
            .forEach { dragHeroItem, hero, destination in
                addToGrid(hero, at: destination) { refreshGrid(at: $0) }
                dropCoordinator.drop(dragHeroItem, toItemAt: destination)
            }

        dragCoordinator.completed = true
    }

    private func addToGrid(_ hero: Hero, at indexPath: IndexPath, resolveGrid: ((IndexPath)-> Void)) {
        grid[indexPath.item] = GridObject(hero: hero)
        resolveGrid(indexPath)
    }

    private func refreshGrid(at indexPath: IndexPath) {
        self.collectionView.performBatchUpdates({
            self.collectionView.reloadItems(at: [indexPath])
        }, completion: nil)
    }
}
