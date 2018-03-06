// AmazingColletionView
// Created by Daniel Budyński 👾
// MacOS 10.12, Swift 4.0

import Foundation

struct HeroesBuilder {

    var playerHeroes: [Hero] {
        return friendlyHeroes(10).sorted { (_, _) in return arc4random_uniform(UInt32(allHeroes.count)) > allHeroes.count / 2 ? true : false }
    }

    var enemyHeroes: [Hero] {
        return enemyHeroes(10).sorted { (_, _) in return arc4random_uniform(UInt32(allHeroes.count)) > allHeroes.count / 2 ? true : false }
    }

    func generateRandomEnemyHero() -> Hero {
        let randomEnemyHeroes = enemyHeroes(10)
        let randomIndex = Int(arc4random_uniform(UInt32(randomEnemyHeroes.count)))
        return randomEnemyHeroes[randomIndex]
    }

    func generateRandomPlayerHero() -> Hero {
        let randomfriendlyHeroes = friendlyHeroes(10)
        let randomIndex = Int(arc4random_uniform(UInt32(randomfriendlyHeroes.count)))
        return randomfriendlyHeroes[randomIndex]
    }

    private func enemyHeroes(_ count: Int) -> [Hero] {
        return [Int](0...10)
            .map { (_) -> Hero in
                let randomIndex = Int(arc4random_uniform(UInt32(allHeroes.count)))
                return allHeroes[randomIndex]
            }
            .map { (hero) in
                var mutableHero = hero
                mutableHero.role = Role.enemy
                return mutableHero
            }
    }

    private func friendlyHeroes(_ count: Int) -> [Hero] {
        return [Int](0...10)
            .map { (_) -> Hero in
                let randomIndex = Int(arc4random_uniform(UInt32(allHeroes.count)))
                return allHeroes[randomIndex]
            }
            .map { (hero) in
                var mutableHero = hero
                mutableHero.role = Role.player
                return mutableHero
            }
    }

    private var allHeroes = [Hero(name: "Dagger", power: .love, value: 14),
                             Hero(name: "Dazzler", power: .strentgh, value: 13),
                             Hero(name: "Hulk", power: .stone, value: 14),
                             Hero(name: "Phoenix", power: .dark, value: 11),
                             Hero(name: "Powerman", power: .stone, value: 12),
                             Hero(name: "Quasar", power: .technology, value: 15),
                             Hero(name: "Submariner", power: .magic, value: 16),
                             Hero(name: "Thor", power: .strentgh, value: 18),
                             Hero(name: "Wolverin", power: .strentgh, value: 10),
                             Hero(name: "Shadowcat", power: .love, value: 25),
                             Hero(name: "Cyclops", power: .technology, value: 8),
                             Hero(name: "Spiderman", power: .strentgh, value: 30),
                             Hero(name: "Galactus", power: .god, value: 75),
                             Hero(name: "Punisher", power: .stone, value: 47),
                             Hero(name: "Dormammu", power: .magic, value: 69),
                             Hero(name: "Captain America", power: .strentgh, value: 31),
                             Hero(name: "Stan Lee", power: .love, value: 161),
                             Hero(name: "Captain Britain", power: .strentgh, value: 40)]
}
