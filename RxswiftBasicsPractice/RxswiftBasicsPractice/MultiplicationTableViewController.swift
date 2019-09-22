//
//  MultiplicationTableViewController.swift
//  RxswiftBasicsPractice
//
//  Created by ChanWook Park on 22/09/2019.
//  Copyright © 2019 Ios_Park. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MultiplicationTableViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var numberInputTextField: UITextField!
    @IBOutlet weak var resultLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension MultiplicationTableViewController {
    func bind() {
        let textToNumber: (String) -> Observable<Int> = { text -> Observable<Int> in
            guard let number = Int(text) else {
                return Observable.empty()
            }
            return Observable.just(number)
        }
        let inputNumber = numberInputTextField.rx.text.orEmpty.flatMap(textToNumber)
        inputNumber
            .flatMap { dan -> Observable<String> in
                return Observable.range(start: 1, count: 9).map({ (step) -> String in
                    return "\(dan) * \(step) = \(dan * step)\n"
                }).reduce("", accumulator: {$0 + $1})
            }
            .bind(to: resultLb.rx.text)
            .disposed(by: disposeBag)
    }
}
