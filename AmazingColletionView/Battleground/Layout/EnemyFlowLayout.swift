// AmazingColletionView
// Created by Daniel Budyński 👾
// MacOS 10.12, Swift 4.0

import UIKit

class EnemyFlowLayout: UICollectionViewFlowLayout {

    var insertionIndexPathArray = [IndexPath]()

    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        insertionIndexPathArray.removeAll()

        updateItems
            .filter { $0.updateAction == .insert }
            .flatMap { $0.indexPathAfterUpdate }
            .forEach { insertionIndexPathArray.append($0)}
    }

    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

        let attributes = super.layoutAttributesForItem(at: itemIndexPath)

        if insertionIndexPathArray.contains(itemIndexPath) {
            let translationTransform = CGAffineTransform(translationX: 0, y: -150)
            let scaleTransform = CGAffineTransform(scaleX: 0.65, y: 0.9)
            attributes?.transform = translationTransform.concatenating(scaleTransform)
            attributes?.alpha = 0.6
        }

        return attributes
    }
}
