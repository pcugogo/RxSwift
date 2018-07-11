# RxSwift

## RxSwift = ReactiveX + Swift
반응형 프로그래밍을 할 수 있게 해주는 확장팩

### ReactiveX가 사용하는 도구

***Observer Pattern***

***Iterator Pattern***

***Functional Programming 함수형 프로그래밍***

    수학적 함수의 조합으로 프로그램 구성
    상태를 바꾸지 않고, 불변 자료형 사용
    고차 함수
       - 함수를 다른 함수의 파라미터로 전달
       - 함수를 다른 함수에서 결과로 변환
    순수 함수
       - 부작용을 발생시키지 않는 함수(부작용 - 함수 스코프를 벗어나서 바깥 세상에 변화를 가하는 행동)
       - 참조 투명성이 있는 함수(입력이 동일하다면 출력도 항상 동일(인자 + 전역변수가 결과 값인 함수는 전역 변수가 변하면 값이 변하기 때문에 투명성이 없다 인자 + 인자 인 값은 입력한 값에 의해서만 값이 나오기 때문에 투명성이 있다))







## Observable


***Observables Sequences***
>**1.** Observable Sequence(출력할 수열)를 만든다
```Observable<Int>.from([1,2,3,4,5])```
//출력할 수열 1,2,3,4,5

***subScribe***
>**2.** subScribe(구독) 출력할 형식을 지정
```
.subscribe({ event in
switch event {
case let .next(element) : 
print("\(element)")
case .error(let error):  
print(error.localizedDescription)
case .completed:
print("completed")
}
})
```

***Disposing***
>**3.** dispose하여 메모리를 해제시킨다
```.disposed(by: disposeBag) or disposeBag = DisposeBag()
```

>Observables의 사용이 끝나면 메모리를 해제해야 합니다. 그 때 사용할 수 있는것이 Dispose입니다. RxSwift에서는 DisposeBag을 사용하는데 DisposeBag instance의 deinit() 이 실행 될 때 모든 메모리를 해제합니다.

***출력***
>**4.** 값이 출력된다
>
>  1,2,3,4,5
>
>  completed


## Subjects
Rx 에서 Subject는 Observable 과 Observer 둘 다 될 수 있는 특별한 형태입니다. Subject는 Observables을 subscribe(구독) 할 수 있고 다시 emit(방출)할 수 도 있습니다. 혹은 새로운 Observable을 emit 할 수 있습니다.

***PublishSubject***
>PublishSubject는 subscribe 전의 이벤트는 emit하지 않습니다. subscribe한 후의 이벤트만을 emit합니다. 그리고 에러 이벤트가 발생하면 그 후의 이벤트는 emit 하지 않습니다.

>옵저버와 옵저버블을 동시에 구현한다
>
>즉 On과 Subscribe를 둘 다 할 수 있다.

>스스로 일어나는 이벤트가 아닌경우에 사용한다.>즉 이벤트를 외부에서 전달해줄 경우에 사용 

>Delegate 대신 사용하기도 한다.

***BehaviorSubject***
>BehaviorSubject는 PublishSubject와 거의 같지만 BehaviorSubject는 반드시 값으로 초기화를 해줘야 합니다. 즉 BehaviorSubject는 Observer에게 subscribe하기전 마지막 이벤트 혹은 초기 값을 emit합니다.

>마지막 Event를 꺼내올 수 있다.

>Subscribe와 상관없이 데이터에 접근 해야할 경우 사용

>-Datasource

***ReplaySubject***
>ReplaySubject는 미리 정해진 사이즈 만큼 ***가장 최근***의 이벤트를 새로운 Subscriber에게 전달 합니다.
>```
var replaySubject = ReplaySubject<String>.create(bufferSize: 1)
replaySubject.onNext("before subscribe first value")
replaySubject.onNext("before subscribe second value")```

이 부분에서 버퍼 사이즈가 1이기 때문에 가장 최근의 이벤트인 “before subscribe second value”를 새로운 구독자에게 전달합니다.

***Variable***
>Variable 은 BehaviorSubject의 Wrapper 함수입니다. BehaviorSubject처럼 작동하며 더 익숙한 이름으로 사용하기 위해 만들어 졌습니다. Variable은 Error 이벤트를 Emit 하지 않습니다. deinit에서 해제 되며 Completed이벤트를 Emit합니다.

***참고사이트 출처:*** <https://medium.com/ios-forever/rxswift-%EA%B8%B0%EB%B3%B8-%EC%9D%B5%ED%9E%88%EA%B8%B0-1-d4d77ce63ca8>