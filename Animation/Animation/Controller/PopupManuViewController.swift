//
//  ViewController.swift
//  Animation
//
//  Created by Petar Lemajic on 10/15/18.
//  Copyright © 2018 Petar Lemajic. All rights reserved.
//

import UIKit
import MapKit

private enum ActionState {
    case closed
    case open
}

extension ActionState {
    var opposite: ActionState {
        switch self {
        case .closed: return .open
        case .open: return .closed
        }
    }
}

class PopupManuViewController: UIViewController {

    private var bottomConstraint = NSLayoutConstraint()
    private var currentState: ActionState = .closed


    private lazy var slideView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()

    private lazy var tapGesture: UITapGestureRecognizer = {
        let recogniser = UITapGestureRecognizer()
        recogniser.addTarget(self, action: #selector(popupViewTapped(gesture:)))
        return recogniser
    }()

    private lazy var map: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        slideViewCornerRadius()
        setupMapView()
        slideView.addGestureRecognizer(tapGesture)
    }

    fileprivate func layout() {
        slideView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slideView)
        slideView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        slideView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomConstraint = slideView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 440)
        bottomConstraint.isActive = true
        slideView.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }

    fileprivate func slideViewCornerRadius() {
        slideView.layer.cornerRadius = 16
    }

    fileprivate func setupMapView() {
        map.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(map)
        map.leadingAnchor.constraint(equalTo: slideView.leadingAnchor, constant: 30).isActive = true
        map.trailingAnchor.constraint(equalTo: slideView.trailingAnchor, constant: -30).isActive = true
        map.bottomAnchor.constraint(equalTo: slideView.bottomAnchor, constant: -60).isActive = true
        map.topAnchor.constraint(equalTo: slideView.topAnchor, constant: 70).isActive = true
    }

    @objc fileprivate func popupViewTapped(gesture: UITapGestureRecognizer) {
        let state = currentState.opposite
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = 440
            }
            self.view.layoutIfNeeded()
        })
        transitionAnimator.addCompletion { position in
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            }
            switch self.currentState {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = 440
            }
        }
        transitionAnimator.startAnimation()
    }
}
