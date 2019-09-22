//
//  PlusThreeNumbersViewController.swift
//  RxswiftBasicsPractice
//
//  Created by ChanWook Park on 22/09/2019.
//  Copyright © 2019 Ios_Park. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PlusThreeNumbersViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    @IBOutlet weak var firstNumberTextField: UITextField!
    @IBOutlet weak var secondNumberTextField: UITextField!
    @IBOutlet weak var thirdNumberTextField: UITextField!
    @IBOutlet weak var resultLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension PlusThreeNumbersViewController {
    func bind() {
        let textToNumber: (String) -> Observable<Int> = { text -> Observable<Int> in
            guard let number = Int(text) else {
                return Observable.empty()
            }
            return Observable.just(number)
        }
        
        let firstNumber = firstNumberTextField.rx.text.orEmpty.flatMap(textToNumber)
        let secondNumber = secondNumberTextField.rx.text.orEmpty.flatMap(textToNumber)
        let thirdNumber = thirdNumberTextField.rx.text.orEmpty.flatMap(textToNumber)
        
        Observable.combineLatest([firstNumber, secondNumber, thirdNumber]) { numbers -> Int in
            return numbers.reduce(0, +)
            }.map{String($0)}.subscribe { event in
                switch event {
                case .next(let value):
                    self.resultLb.text = value
                default :
                    break
                }
        }.disposed(by: disposeBag)
    }
}
