//
//  AnimationViewController.swift
//  RxswiftBasicsPractice
//
//  Created by ChanWook Park on 23/09/2019.
//  Copyright © 2019 Ios_Park. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AnimationViewController: UIViewController {

    var disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var boxView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension AnimationViewController {
    func bind() {
        leftButton.rx.tap.map{Animation.left}.bind(to: boxView.rx.animation).disposed(by: disposeBag)
        rightButton.rx.tap.map{Animation.right}.bind(to: boxView.rx.animation).disposed(by: disposeBag)
        upButton.rx.tap.map{Animation.up}.bind(to: boxView.rx.animation).disposed(by: disposeBag)
        downButton.rx.tap.map{Animation.down}.bind(to: boxView.rx.animation).disposed(by: disposeBag)
    }
}

extension Reactive where Base: UIView {
    var animation : Binder<Animation>{
        return Binder(self.base, binding: { (view, animation) in
            UIView.animate(withDuration: 1, animations: {
                view.transform = animation.transform(view.transform)
            })
        })
    }
}

enum Animation {
    case left
    case right
    case up
    case down
}

extension Animation {
    func transform(_ transform: CGAffineTransform) -> CGAffineTransform {
        switch self {
        case .left:
            return transform.translatedBy(x: -50, y: 0)
        case .right:
            return transform.translatedBy(x: 50, y: 0)
        case .up:
            return transform.translatedBy(x: 0, y: -50)
        case .down:
            return transform.translatedBy(x: 0, y: 50)
        }
    }
}
