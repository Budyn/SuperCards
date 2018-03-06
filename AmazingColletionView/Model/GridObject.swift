// AmazingColletionView
// Created by Daniel Budyński 👾
// MacOS 10.12, Swift 4.0

struct GridObject {
    var hero: Hero?

    static func defaultGrid(_ size: Int) -> [GridObject] {
        return [Int](0...size).map { (_) in return GridObject() }
    }
}
