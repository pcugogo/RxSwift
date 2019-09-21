//
//  RelayViewController.swift
//  RxswiftBasicsPractice
//
//  Created by ChanWook Park on 21/09/2019.
//  Copyright © 2019 Ios_Park. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RelayViewController: UIViewController {

    let disposeBag:DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rxinit()
    }
    



}

extension RelayViewController {
    func rxinit() {
        
        //PublishRelay
        print("PublishRelay")
        let publishRelay = PublishRelay<[Int]>()
        publishRelay.subscribe(onNext: { print("frist: \($0)") },
                               onError: { print("frist: \($0)") },
                               onCompleted: { print("frist: onCompleted") }, onDisposed: { print("string frist: onDisposed")})
            .disposed(by: disposeBag)
        publishRelay.accept([1,2,3])
        publishRelay.accept([10,20,30])
        
        publishRelay.subscribe(onNext: { print("second: \($0)") },
                               onError: { print("second: \($0)") },
                               onCompleted: { print("second: onCompleted") }, onDisposed: { print("string second: onDisposed")})
            .disposed(by: disposeBag)
        //Completed 되지 않음 화면전환 시에 Completed됨
        publishRelay.accept([100,200,300]) //first, second 둘다 출력
        publishRelay.accept([1000,2000,3000]) //first, second 둘다 출력
        
        //BehaviorRelay 한번에 여러개의 값을 최신 값으로 업데이트 가져올 때 유용할 것같다.
        print("behaviorRelay")
        let behaviorRelay: BehaviorRelay<[Int]> = BehaviorRelay(value: [10, 20, 30])
        behaviorRelay.accept([20, 10]) //안나옴
        behaviorRelay.accept([10, 20]) //최신 값만 나옴
        behaviorRelay.asObservable().subscribe(onNext: { number in
            print("\(number)") //10,20
        }).dispose()
        behaviorRelay.accept([25, 15])
        behaviorRelay.asObservable().subscribe(onNext: { number in
            print("\(number)") //25, 15
        }).dispose()
        behaviorRelay.accept([250, 150])//출력 안됨
    }
}
