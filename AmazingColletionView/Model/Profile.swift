// AmazingColletionView
// Created by Daniel Budyński 👾
// MacOS 10.12, Swift 4.0

import Foundation

enum ProfileContext {
    case enemy
    case player
    case battleground
}

protocol Profile {
    var heroes: [Hero] { get set }
    var context: ProfileContext { get }
}

struct Enemy: Profile {
    var heroes = HeroesBuilder().enemyHeroes
    let context = ProfileContext.enemy
}

struct Player: Profile {
    var heroes = HeroesBuilder().playerHeroes
    let context = ProfileContext.player
}

struct ProfileList {

    static var shared: ProfileList = {
        var defaultProfileList: [Profile] = [Enemy(), Player()]
        return ProfileList(profileList: defaultProfileList)
    }()

    private var profileList: [Profile]

    init(profileList: [Profile]) {
        self.profileList = profileList
    }

    func heroes(for context: ProfileContext) -> [Hero] {
        let profile = fetchProfile(forContext: context)
        return profile.heroes
    }

    func hero(at index: Int, in context: ProfileContext) -> Hero? {
        let profile = fetchProfile(forContext: context)
        return profile.heroes[index]
    }

    mutating func appendToEnd(heroes: [Hero], into context: ProfileContext) -> Int {
        var profile = fetchProfile(forContext: context)
        update(profileContext: context, with: profile.heroes + heroes)
        return profile.heroes.count
    }

    mutating func insert(heroes: [Hero], into context: ProfileContext, at index: Int) {
        var profile = fetchProfile(forContext: context)
        update(profileContext: context, with: heroes + profile.heroes)
    }

    mutating func deleteHeroes(at indexes: [Int], in context: ProfileContext) -> [Hero] {
        var profile = fetchProfile(forContext: context)

        let removedHeros = profile.heroes
                            .enumerated()
                            .filter({ indexes.contains($0.offset) })
                            .map { $0.element }

        let restOfTheHeroes = profile.heroes
                                .enumerated()
                                .filter({ !indexes.contains($0.offset) })
                                .map { $0.element }

        update(profileContext: profile.context, with: restOfTheHeroes)
        return removedHeros
    }

    private mutating func update(profileContext: ProfileContext, with heroes: [Hero]) {
        switch profileContext {
        case .player:
            var updatedProfileList = profileList.filter {  $0.context != profileContext }
            var player = Player()
            player.heroes = heroes
            updatedProfileList.append(player)
            profileList = updatedProfileList
        case .enemy:
            var updatedProfileList: [Profile] = profileList.filter {  $0.context != profileContext }
            var enemy = Enemy()
            enemy.heroes = heroes
            updatedProfileList.append(enemy)
            profileList = updatedProfileList
        case .battleground:
            return
        }
    }

    private func fetchProfile(forContext context: ProfileContext) -> Profile {
        let contextProfiles = profileList.filter { $0.context == context }
        return contextProfiles.first!
    }

}
