// AmazingColletionView
// Created by Daniel Budyński 👾
// MacOS 10.12, Swift 4.0

import UIKit

enum Role {
    case enemy
    case player
}

enum Power: String {
    case love = "❤️"
    case dark = "🌚"
    case technology = "🤖"
    case strentgh = "💪🏻"
    case team = "👫"
    case magic = "🔮"
    case god = "🌎"
    case stone = "🗿"
}

struct Hero  {
    let name: String
    let power: Power
    let value: Int
    var role: Role? = nil

    init(name: String, power: Power, value: Int, role: Role? = nil) {
        self.name = name
        self.power = power
        self.value = value
        self.role = role
    }

    func frontCardImage() -> UIImage {
        let imageName = name.filter { $0 != " " }.lowercased() + "-card-front"
        return UIImage(named: imageName)!
    }

    func backCardImage() -> UIImage {
        let imageName = name.filter { $0 != " " }.lowercased() + "-card-back"
        return UIImage(named: imageName)!
    }
}

extension Hero: Equatable {
    static func == (lhs: Hero, rhs: Hero) -> Bool {
        return  lhs.name == rhs.name &&
                lhs.role == rhs.role &&
                lhs.power == rhs.power &&
                lhs.value == rhs.value
    }
}


