//
//  ViewController.swift
//  RxObservableTest
//
//  Created by ChanWook Park on 2018. 7. 7..
//  Copyright © 2018년 Ios_Park. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    var disposeBag:DisposeBag = DisposeBag()
    
    @IBOutlet weak var ATextField: UITextField!
    @IBOutlet weak var BTextField: UITextField!
    @IBOutlet weak var CTextField: UITextField!
    
    @IBOutlet weak var resultLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
//        rxInit()
        
    }
    
}

extension ViewController {
    
    func rxInit(){
        
        let textToNumber:(String?) ->Observable<Int> = { text -> Observable<Int> in
            
            guard let text = text, let value = Int(text) else{
                return Observable.empty()
            }
            return Observable.just(value)
        }
        
        let aValueObservable = ATextField.rx.text.asObservable().flatMap(textToNumber)
        let bValueObservable = BTextField.rx.text.asObservable().flatMap(textToNumber)
        let cValueObservable = CTextField.rx.text.asObservable().flatMap(textToNumber)
        
//        ATextfield.rx.text.asObservable().flatMap(textToNumber)
//        { text -> Observable<Int> in
//            guard let text = text, let value = Int(text) else{
//                return Observable.empty()
//            }
//            return Observable.just(value)
//        }
        
        Observable.combineLatest([aValueObservable,bValueObservable,cValueObservable]) { (values) -> Int in
            
            return values.reduce(0, +)
            }.map {("\($0)")}.subscribe { event in
                switch event{
                case .next(let value):
                    self.resultLb.text = value
                default:
                    break
                }
        }.disposed(by: disposeBag)
    }
    
    
    
    
    func bind() {
        
        let subScriber: (Event<Int>) -> Void = { event in
            switch event {
            case let .next(element) : //let 밖에
                print("\(element)")
            case .error(let error):  //안에 써도 같은 의미 let error 옆에 ,쓰고 줄줄이 더 쓸 수 있다
                print(error.localizedDescription)
            case .completed:
                print("completed")
            }
        }
        //옵져버는 어떻게 관찰을 할까? 의 경우의 수 5개
        //Operator
        Observable<Int>.just(1).subscribe(subScriber).disposed(by: disposeBag)
        
        Observable<Int>.from([1,2,3,4,5]).subscribe(subScriber).disposed(by: disposeBag)
        
        Observable<Int>.of(5,4,3,2,1).subscribe(subScriber).disposed(by: disposeBag)
        
        Observable<Int>.empty().subscribe(subScriber).disposed(by: disposeBag)
        print("-")
        
        Observable<Int>.never().subscribe(subScriber).disposed(by: disposeBag)
        print("_")
        
        Observable<Int>.error(RxError.unknown).subscribe(subScriber).disposed(by: disposeBag)
        
        //create로 Observable Sequence를 직접 만들 수 있다 /1. onNext로 올린 숫자들을 /2. subScribe(구독)의 형식으로 출력한다 /3. dispose하여 메모리를 해제시킨다
        Observable<Int>.create { observer -> Disposable in
            observer.on(Event.next(1))
            observer.onNext(2) // 위 코드랑 같다
            observer.onNext(4)
            observer.onNext(8)
            observer.onNext(16)
            observer.onCompleted()
            
            return Disposables.create {
                print("Dispose!!!")
            }
            }.subscribe({ event in
                switch event {
                case let .next(element) : //let 밖에
                    print("\(element)")
                case .error(let error):  //안에 써도 같은 의미 let error 옆에 ,쓰고 줄줄이 더 쓸 수 있다
                    print(error.localizedDescription)
                case .completed:
                    print("completed")
                }
            }).disposed(by: disposeBag) //이렇게 디스포즈(메모리 해제)해도 되고
//        disposeBag = DisposeBag() //이렇게 디스포즈 해도 됨
        
        
        Observable<Int>.repeatElement(1000).take(10).subscribe(subScriber).disposed(by: disposeBag)// take 쓰면 10번 디스포즈
        
//        Observable<Int>.interval(0.5, scheduler: MainScheduler.instance).take(20).subscribe(subScriber).disposed(by: disposeBag)
        
        
        //퍼블리쉬 스크립트는 한몸
        let publishSubject: PublishSubject<Int> = PublishSubject()
        publishSubject.onNext(0)
        publishSubject.onNext(2)
        //위는 약속 전
        publishSubject.subscribe(subScriber).disposed(by: disposeBag) //약속 시점
        publishSubject.onNext(20)
        publishSubject.onNext(22)
        
        //BehaviorSubject 초기값이 1개 있다 마지막 Event를 꺼내올 수 있다. SubScribe와 상관없이 데이터에 접근 해야할 경우 사용 - Datasource
        let behaviorSubject :BehaviorSubject<Int> = BehaviorSubject(value: 200)
        behaviorSubject.onNext(100) //여기서 초기값 200이 100으로 바뀜
        behaviorSubject.subscribe(subScriber).disposed(by: disposeBag) // 여기서 바뀐 100으로 약속 약속을 여러번 할 수 있다
        behaviorSubject.onNext(300)
        behaviorSubject.onNext(400)
        
    }
}

