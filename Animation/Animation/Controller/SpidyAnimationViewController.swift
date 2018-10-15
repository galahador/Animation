//
//  SpidyAnimationViewController.swift
//  Animation
//
//  Created by Petar Lemajic on 10/15/18.
//  Copyright © 2018 Petar Lemajic. All rights reserved.
//

import UIKit

class SpidyAnimationViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var questionMarkViewOne: UIView!
    @IBOutlet weak var questionMarkViewTwo: UIView!
    @IBOutlet weak var questionMarkViewThre: UIView!
    @IBOutlet weak var headLine: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
        setuplabel()
    }

    override func viewWillDisappear(_ animated: Bool) {
        nukeAllAnimations()
    }

    fileprivate func setuplabel() {
        headLine.layer.cornerRadius = 16
        headLine.text = "Wops nothing to read"
    }

    fileprivate func repeatAnimation() {
        UIView.setAnimationRepeatCount(50)

        self.questionMarkViewOne.alpha = 0.0
        self.questionMarkViewOne.alpha = 1.0

        self.questionMarkViewTwo.alpha = 0.0
        self.questionMarkViewTwo.alpha = 1.0

        self.questionMarkViewThre.alpha = 0.0
        self.questionMarkViewThre.alpha = 1.0
    }

    fileprivate func startAnimation() {
        UIView.animate(withDuration: 1.5,
            delay: 0.5,
            options: [.autoreverse, .repeat],
            animations: {
                self.setuplabel()
                self.repeatAnimation()
            },
            completion: { finished in
                print("Animation is done")
            })
    }

    func nukeAllAnimations() {
        self.view.subviews.forEach({ $0.layer.removeAllAnimations() })
        self.view.layer.removeAllAnimations()
        self.view.layoutIfNeeded()
    }
}
