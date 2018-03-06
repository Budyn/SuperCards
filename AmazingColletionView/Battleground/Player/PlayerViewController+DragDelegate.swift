// AmazingColletionView
// Created by Daniel Budyński 👾
// MacOS 10.12, Swift 4.0

import UIKit

extension PlayerViewController: UICollectionViewDragDelegate {

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let coordinator = DragCoordinator(sourceContext: context)
        session.localContext = coordinator
        return [coordinator.dragHeroItem(at: indexPath)]
    }

    func collectionView(_ collectionView: UICollectionView, dragSessionDidEnd session: UIDragSession) {
        guard
            let dragCoordinator = session.localContext as? DragCoordinator,
            dragCoordinator.sourceContext == context,
            dragCoordinator.completed == true
            else { return }

        collectionView.performBatchUpdates({
            collectionView.deleteItems(at: dragCoordinator.sourceIndexPaths)
        }, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let parameters = UIDragPreviewParameters()
        parameters.backgroundColor = .clear

        guard let cellBounds = collectionView.cellForItem(at: indexPath)?.bounds else { return parameters }
        let visibleBounds = CGRect(x: cellBounds.minX + 5, y: cellBounds.minY + 5, width: cellBounds.width - 10, height: cellBounds.height - 10)
        parameters.visiblePath = UIBezierPath(roundedRect: visibleBounds, cornerRadius: 4)

        return parameters
    }

    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        guard
            let dragCoordinator = session.localContext as? DragCoordinator,
            dragCoordinator.sourceContext == context
            else { return [] }

        return [dragCoordinator.dragHeroItem(at: indexPath)]
    }
}
