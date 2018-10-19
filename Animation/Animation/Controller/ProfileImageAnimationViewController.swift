//
//  ProfileImageAnimationViewController.swift
//  Animation
//
//  Created by Petar Lemajic on 10/19/18.
//  Copyright © 2018 Petar Lemajic. All rights reserved.
//

import UIKit

class ProfileImageAnimationViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    let profileImageWidth: CGFloat = 110

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageCornerRadius()
        animateProfileImage()
    }

    fileprivate func profileImageCornerRadius() {
        profileImageView.layer.cornerRadius = 10
        profileImageView.clipsToBounds = true
    }

    fileprivate func animateProfileImage() {
        UIView.animate(withDuration: 2.0) {
            UIView.setAnimationRepeatAutoreverses(true)
            self.profileImageView.frame = CGRect(x: 0, y: 0, width: self.profileImageWidth, height: self.profileImageWidth)
            self.profileImageView.center = self.view.center
            self.profileImageView.layer.cornerRadius = self.profileImageWidth / 2
        }
    }
}
