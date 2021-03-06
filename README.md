# RxSwift를 정리하고 학습 하는 공간

## ReactiveX
An API for asynchronous programming
with observable streams
옵져버블을 가지고 async 프로그래밍을 하는 api다

## RxSwift = ReactiveX + Swift
반응형 프로그래밍을 할 수 있게 해주는 확장팩


## Functional Programming (함수형 프로그래밍)

### 순수 함수
- 부작용을 발생시키지 않는 함수
- **부작용(side effect)**: 함수 스코프를 벗어나서 바깥 세상에 변화를 가하는 행동
 
### 참조 투명성

- 입력이 동일하다면 출력도 항상 같아야한다.

### 일급 함수
- 인자로 보낼 수 있다.
- 값으로 반환할 수 있다.
- 변수에 저장할 수 있다.

# Rxswift
- Reaction - Action: Reaction을 하기 위해서는 Action을 관찰해야한다.
- Observer: 관찰하는 주체
- Observable: 관찰되는 대상

## Subscribe, Emit, Dispose

- Subscribe: 구독
 - Observer는 Observable을 구독한다.
 - Observable은 subscribe가 있기 전까지 아무 일도 하지 않는다. 
 - 구독을 하면 Observable이 이벤트를 발생시키고 complete 또는 error 이벤트가 발생하기 전까지 계속 next 이벤트를 발생시킨다.
 - disposable 객체를 반환한다.
- Emit: 발행
 - Observable은 Event를 Emit(발행)한다.
- Dispose: 처분
 - Observable은 Event발행이 Complete(완료)되면 Dispose된다.

## Bind

- 바인더를 메인스레드에서 실행해주기때문에 메인스레드 처리를 따로 처리할 필요가 없다.

## Event

- Obsevable은 Event를 Emit 한다.
- Observer는 Observable로 부터 Event를 Subscribe 한다.
- error 또는 completed 되면 스트림이 종료 되면서 메모리가 해제된다.
- error나 completed하지 않고 스트림이 종료되지 않는 상태로 뷰 전환을 하게 된다면 self의 강한참조로 인해 메모리릭 상태가 될 수 있기때문에 주의해야한다.
참고 사이트: [곰튀김님 강의](https://www.youtube.com/watch?v=687KaKJ8B7U)

## Dispose

- 구독을 중단 한다.
- 구독이 중단되면, Observable은 더 이상 이벤트를 발생시키지 않는다.
- dispose() 함수: 즉시 처분
- disposeBag: disposable 들을 모아놨다가 한번에 처분

## Observable 생성

- just: Element를 1개 Emit 한다.
- from: Element를 Array로 보내고 하나씩 Emit한다.
- of: Emit할 Element 들을 함수 인자로 기입
- empty: 아무 Element를 보내지 않음. complete는 보냄.
- never: 아무 Event를 보내지 않음.
- error: Error Event를 1개 Emit 한다.
- create: Observer에 직접 Event를 Emit한다.
- repeatElement: 지정된 element를 계속 Emit 한다.
- interval: 지정된 시간에 한번씩 event를 emit

## Subject
- 옵저버와 옵저버블을 동시에 구현한다
- 즉, emit과 Subscribe를 둘 다 할 수 있다.

### PublishSubject
- 스스로 일어나는 이벤트가 아닌 경우에 사용한다.
 - 즉 이벤트를 외부에서 전달해줄 경우에 사용 
- subscribe 전의 이벤트는 emit하지 않는다.
- error가 발생하면 그 후의 이벤트는 emit하지않는다.

### BehaviorSubject
- 초기값을 가지고 생성된다. 반드시 초기 값을 설정해야한다.
- subscribe가 발생하면, 발생한 시점 이전에 발생한 이벤트 중 가장 최신의 이벤트를 받는다. 주로 마지막 값을 받을 때 사용한다.

### ReplaySubject
- 미리 정해진 사이즈(bufferSize) 만큼 이벤트를 저장해 새로운 Subscriber에게 전달 한다. 

### Relay
- Subject와 다르게 error 나 complete 를 통해서 완전종료될 수 없다
- subscribe 하고 싶을 때는 asObservable을 사용한다.

### Relay - PublishRelay
- PublishSubject를 wrapping 해서 가지고 있다.
- Subject 는 .completed 나 .error 를 받으면 subscribe 이 종료된다. 하지만 PublishRelay는 dispose되기 전까지 계속 작동하기 때문에 UI Event에서 사용하기 적절하다.

### Relay - BehaviorRelay
- BehaviorSubject를 wrapping 해서 가지고 있다.
- .value를 사용해 현재의 값을 꺼낼 수 있다.
- .value는 get only property이다.
- value를 변경하기 위해 .accept()를 사용한다.

## 다양한 Operators

### Transforming - map
- 이벤트를 바꾼다.

### Transforming - flatMap
- 이벤트를 다른 옵저버블로 바꾼다.

### Filtering - filter
- 조건 맞는 이벤트를 방출한다.

### Filtering - take
- take(n) n개의 이벤트를 방출한다.
- 이벤트 개수를 초과하여 작성할 경우, 작성한 이벤트 개수만큼만 방출한다.

### Filtering - skip
- skip(n): 첫 이벤트 부터 n개의 이벤트는 건너뛴다.


### Filtering - distinctUntilChange
- 이벤트 값이 변경될 때 event를 발생시킨다.

```
Observable.from([0, 0, 1, 1, 2]).distinctUntilChanged()
```

- 첫번째 이벤트 0을 발생시키고 첫번째 값과 같은 값 0을 가진 두번째 이벤트 발생하지않고 세번째 이벤트는 새로운 숫자 1로 변경되었기때문에 발생한다.

### Mathematical and Aggregate - Reduce
- 이벤트들을 모두 합쳐서 방출한다.

### Combination-merge
- 이벤트 타입이 같은 옵저버블 여러개를 합친다.

### Combination-zip
- 여러 옵저버블에서 이벤트를 한쌍씩 순서대로 합친다. (한쌍이 완성될 때만 발생)

### Combination-combineLatest
- 여러 옵저버블에서 가장 최근 이벤트들을 합친다.

### Combination-withLatestFrom
```
secondNumberObservable.withLatestFrom(firstNumberObservable) { (second, first) -> Int in
    return second * first 
}
```
secondNumber의 이벤트가 emit 될 때마다 매개 변수로 넘겨준 firstNumberObservable의 최신 element를 얻는다.

### Observable share

- 옵저버블을 공유하지 않으면 Subscribe 횟수만큼 이벤트가 발생 한다.

