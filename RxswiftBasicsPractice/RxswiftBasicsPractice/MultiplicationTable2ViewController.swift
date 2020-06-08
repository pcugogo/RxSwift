//
//  MutiplicationTable2ViewController.swift
//  RxswiftBasicsPractice
//
//  Created by ChanWook Park on 23/09/2019.
//  Copyright © 2019 Ios_Park. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MultiplicationTable2ViewController: UIViewController {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var firstNumberLabel: UILabel!
    @IBOutlet weak var secondNumberLabel: UILabel!
    @IBOutlet weak var resultNumberLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    

    func bind() {
        
        let numberObservables: [Observable<Int>] = numberButtons.enumerated().map { (index, button) -> Observable<Int> in
            return button.rx.tap.map{index + 1}
        }
        let numberObservable = Observable.merge(numberObservables)
    
        let firstNumberObservable = numberObservable.enumerated().filter { (index, element) -> Bool in
            return index % 2 == 0
            }.map { (_, number) in return number}

        let secondNumberObservable = numberObservable.enumerated().filter { (index, element) -> Bool in
            return index % 2 == 1
        }.map { (_, number) in return number}
        
        firstNumberObservable.do(onNext: {[weak self] _ in
            self?.secondNumberLabel.text = ""
            self?.resultNumberLabel.text = ""
        })
            .map{"\($0)"}
            .bind(to: firstNumberLabel.rx.text)
            .disposed(by: disposeBag)
        
        secondNumberObservable
            .map{"\($0)"}
            .bind(to: secondNumberLabel.rx.text)
            .disposed(by: disposeBag)
        
        secondNumberObservable.withLatestFrom(firstNumberObservable) { (second, first) -> Int in //secondNumber의 이벤트가 emit 될 때마다 매개 변수로 넘겨준 firstNumberObservable의 최신 element를 얻는다.
            return second * first
            }
            .map{"\($0)"}
            .bind(to: resultNumberLabel.rx.text)
            .disposed(by: disposeBag)
    }

}
