// AmazingColletionView
// Created by Daniel Budyński 👾
// MacOS 10.12, Swift 4.0

import UIKit
import Foundation

class HeroCollectionViewCell: UICollectionViewCell {

    static let reuseID = "HeroCollectionViewCell"

    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var powerTypeLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!

    var hero: Hero? {
        didSet {
            update(withHero: hero)
        }
    }

    var context: ProfileContext?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        setupLabels()
        setupShadowView()
        setupBackgroundImageView()
    }

    private func setupLabels() {
        powerTypeLabel.layer.cornerRadius = powerTypeLabel.bounds.width / 2
        powerTypeLabel.layer.masksToBounds = true
        valueLabel.layer.cornerRadius = powerTypeLabel.bounds.width / 2
        valueLabel.layer.masksToBounds = true
    }

    private func setupBackgroundImageView() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.layer.cornerRadius = 10
        backgroundImageView.layer.masksToBounds = true
    }

    private func setupShadowView() {
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowRadius = 2
        shadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        shadowView.backgroundColor = .clear
    }

    private func update(withHero hero: Hero?) {
        guard let hero = hero else { return }
        backgroundImageView.image = hero.frontCardImage()
        powerTypeLabel.text = hero.power.rawValue
        valueLabel.text = String(hero.value)

        guard let context = context else {
            setNeutralState()
            return
        }

        if context == .battleground {
            if hero.role == Role.enemy {
                setEnemyState()
            } else {
                setPlayerState()
            }
        }
    }

    private func setEnemyState() {
        shadowView.layer.shadowColor = UIColor.enemy.cgColor
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowRadius = 4
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
    }

    private func setPlayerState() {
        shadowView.layer.shadowColor = UIColor.player.cgColor
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowRadius = 4
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
    }

    private func setNeutralState() {
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowRadius = 4
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}

extension HeroCollectionViewCell {

    override func dragStateDidChange(_ dragState: UICollectionViewCellDragState) {
        switch dragState {
        case .none:
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = .identity
                self.alpha = 1.0
            })
        case .dragging:
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                self.alpha = 0.5
            })
        case .lifting:
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            })
        }
    }
}

