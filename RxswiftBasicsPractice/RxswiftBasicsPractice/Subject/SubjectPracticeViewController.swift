//
//  SubjectPracticeViewController.swift
//  RxswiftBasicsPractice
//
//  Created by ChanWook Park on 21/09/2019.
//  Copyright © 2019 Ios_Park. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SubjectPracticeViewController: UIViewController {

    var disposeBag:DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rxinit()
    }
    

}



extension SubjectPracticeViewController {
    
    func rxinit() {
        
        let subScriber: (Event<Int>) -> Void = { event in
            switch event {
            case let .next(element): //let 밖에
                print("\(element)")
            case .error(let error):
                print(error.localizedDescription)
            case .completed:
                print("completed")
            }
            
        }
        
        //PublishSubject
        print("publishSubject")
        let publishSubject: PublishSubject<Int> = PublishSubject() //초기값 없음
        //약속 전
        publishSubject.onNext(0) //서브스크라이브 하기전 온넥스트는 출력되지 않는다
        publishSubject.onNext(2)
        //약속
        publishSubject.subscribe(subScriber).disposed(by: disposeBag)
        //약속 후
        publishSubject.onNext(20) //출력된다.
        publishSubject.onNext(22)
        
        //BehaviorSubject
        print("behaviorSubject")
        let behaviorSubject :BehaviorSubject<Int> = BehaviorSubject(value: 200) //초기값 입력해야 함
        behaviorSubject.onNext(100) //여기서 초기값 200이 100으로 바뀜 subscribe하기전 마지막 on 값으로 emit
        behaviorSubject.subscribe(subScriber).disposed(by: disposeBag)
        behaviorSubject.onNext(300)
        behaviorSubject.onNext(400)
     
        
        //ReplaySubject
        // bufferSize 가 0이면 PublicSubject와 똑같다.
        let bufferSize = 1
        print("bufferSize : \(bufferSize)")
        
        let subject = ReplaySubject<Int>.create(bufferSize: bufferSize) //1. 버퍼 갯수만큼 저장하여
        subject.subscribe(onNext: { print("string frist: \($0)") },
                          onError: { print("string frist: \($0)") },
                          onCompleted: { print("string frist: onCompleted") }, onDisposed: { print("string frist: onDisposed")})
            .disposed(by: disposeBag)
        subject.onNext(0)
        subject.onNext(1)
        subject.onNext(2)
        
        subject.subscribe(onNext: { print("string second: \($0)") }, //2. 새로운 구독을 할때 emit한다.
                          onError: { print("string second: \($0)") },
                          onCompleted: { print("string second: onCompleted") }, onDisposed: { print("string second: onDisposed")})
            .disposed(by: disposeBag)
        
        subject.onNext(3)
        subject.onNext(4)
        
    }
}
