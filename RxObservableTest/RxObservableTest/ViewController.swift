//
//  ViewController.swift
//  RxObservableTest
//
//  Created by ChanWook Park on 20/09/2019.
//  Copyright © 2019 Ios_Park. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum ObservableCreations: Int {
    case just = 0
    case from
    case of
    case empty
    case never
    case error
    case create
    case repeatElement
    case interval
}

class ViewController: UIViewController {
    
    var disposeBag:DisposeBag = DisposeBag()
    var observableCreations = ["just(1)",".from([1,2,3,4,5])",".of(1,2,3,4,5)","empty()",".never()",".error(RxError.unknown)",".create .on(1)~.on(5)",".repeatElement(3)",".interval(0.5) take(20)"]
    
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
}

extension ViewController {
    func observable(creations: ObservableCreations) {
        
        //Subscribe 미리 지정
        let subscribe: (Event<Int>) -> Void = {[weak self] (event: Event) in
            guard let `self` = self else {return}
            switch event {
            case let .next(element):
                self.textView.text = self.textView.text! + "\n\(element)"
                print("\(element)")
                self.textView.scrollRangeToVisible(NSRange(location: self.textView.text.count - 1, length: 0))
            case let .error(error):
                self.textView.text = self.textView.text! + "\n\(error.localizedDescription)"
                print(error.localizedDescription)
            case .completed:
                self.textView.text = self.textView.text! + "\n completed"
                print("completed")
                self.textView.scrollRangeToVisible(NSRange(location: self.textView.text.count - 1, length: 0))
            }
        }
        
        switch creations {
        case .just:
            //Observable 생성 - just: Element 1개를 Emit 한다.
            Observable<Int>.just(1).subscribe {(event: Event) in //Subscribe 직접 생성
                switch event {
                case let .next(element):
                    print("\(element)")
                    self.textView.text = self.textView.text! + "\n\(element)"
                    self.textView.scrollRangeToVisible(NSRange(location: self.textView.text.count - 1, length: 1))
                case let .error(error):
                    self.textView.text = self.textView.text! + "\n\(error.localizedDescription)"
                    print(error.localizedDescription)
                case .completed:
                    self.textView.text = self.textView.text! + "\n completed"
                    print("completed")
                    self.textView.scrollRangeToVisible(NSRange(location: self.textView.text.count - 1, length: 1))
                }
            }.dispose() // dispose() 즉시 처분 함수
        //1과 completed emit한다.
        case .from:
            //Observable 생성 - from: Element를 Array로 보내고 하나씩 Emit한다
            Observable.from([1,2,3,4,5]).subscribe(subscribe).disposed(by: disposeBag)
        //1~5까지 각각 emit하고 completed
        case .of:
            //Observable 생성 - of: Emit할 Element 들을 함수 인자로 기입
            Observable.of(1,2,3,4,5).subscribe(subscribe).disposed(by: disposeBag)
        //1~5까지 각각 emit하고 completed
        case .empty:
            //Observable 생성 - empty: 아무 Element를 보내지 않음. complete는 보냄.
            Observable<Int>.empty().subscribe(subscribe).disposed(by: disposeBag)
        //completed
        case .never:
            //Observable 생성 - never: 아무 Event를 보내지 않음 (completed도 보내지않음)
            Observable<Int>.never().subscribe(subscribe).disposed(by: disposeBag)
        case .create:
            //Observable 생성 - create: Observer에 직접 Event를 Emit한다.
            Observable<Int>.create { (anyObserver: AnyObserver<Int>) -> Disposable in
                anyObserver.on(Event.next(1))
                anyObserver.on(Event.next(2))
                anyObserver.on(Event.next(3))
                anyObserver.on(Event.next(4))
                anyObserver.on(Event.next(5))
                anyObserver.on(Event.completed)
                return Disposables.create {
                    print("dispose")
                }
                }.subscribe(subscribe).disposed(by: disposeBag)
        //1~5까지 각각 emit하고 completed
        case .repeatElement:
            //Observable 생성 - repeatElement: 지정된 element를 계속 Emit 한다.
            Observable<Int>.repeatElement(3).take(10).subscribe(subscribe).disposed(by: disposeBag)
        //3을 10회 emit하고 completed
        case .interval:
            //Observable 생성 - interval: 지정된 시간에 한번씩 event를 emit
            Observable<Int>.interval(0.5, scheduler:
                MainScheduler.instance).take(20).subscribe(subscribe).disposed(by: disposeBag)
            //0부터 19까지 각각 emit하고 completed
            
        case .error:
            //Observable 생성 - error: Error Event를 1개 Emit 한다.
            Observable<Int>.error(RxError.unknown).subscribe(subscribe).disposed(by: disposeBag)
            //=> The operation couldn’t be completed. (RxSwift.RxError error 1.)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observableCreations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObservableCreationCell", for: indexPath) as! ObservableCreationCell
        cell.observableCreationsLb.text = observableCreations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let observableCreations = ObservableCreations(rawValue: indexPath.row) else {return}
        observable(creations: observableCreations)
    }
}














