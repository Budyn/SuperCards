// AmazingColletionView
// Created by Daniel Budyński 👾
// MacOS 10.12, Swift 4.0

import UIKit

class DragCoordinator {

    var sourceContext: ProfileContext
    var sourceIndexPaths = [IndexPath]()

    var destinationContext: ProfileContext?
    var destinationIndexPaths: [IndexPath]?

    var completed = false

    init(sourceContext: ProfileContext) {
        self.sourceContext = sourceContext
    }

    func dragHeroItem(at indexPath: IndexPath) -> UIDragItem {
        sourceIndexPaths.append(indexPath)

        let hero = ProfileList.shared.hero(at: indexPath.item, in: sourceContext)
        let itemProvider = NSItemProvider(object: hero!.frontCardImage())
        let dragItem = UIDragItem(itemProvider: itemProvider)

        dragItem.previewProvider = {
            let view = Bundle(for: HeroPreview.self).loadNibNamed("HeroPreview", owner: nil, options: nil)?.first as! HeroPreview
            view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
            view.hero = ProfileList.shared.hero(at: indexPath.item, in: self.sourceContext)
            return UIDragPreview(view: view)
        }

        return dragItem
    }

    func calculateDestinationIndexPaths(from indexPath: IndexPath, count: Int) {
        destinationIndexPaths = Array(indexPath.item..<(indexPath.item + count)).map { IndexPath(item: $0, section: 0) }
    }
}
