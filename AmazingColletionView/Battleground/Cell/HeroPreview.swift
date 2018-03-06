// AmazingColletionView
// Created by Daniel Budyński 👾
// MacOS 10.12, Swift 4.0

import UIKit

class HeroPreview: UIView{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    
    var hero: Hero? {
        didSet {
            update(withHero: hero)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        imageView.contentMode = .scaleToFill
        frontImageView.contentMode = .scaleToFill
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.masksToBounds = true
    }

    private func update(withHero hero: Hero?) {
        guard let hero = hero else { return }
        imageView.image = hero.backCardImage()
        frontImageView.image = hero.frontCardImage()
    }
}
