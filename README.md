# RxSwift를 정리하고 학습 하는 공간

### RxSwift 이론을 학습하며 기능들을 사용해보고 간단한 미니프로젝트를 만들 계획입니다.

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
- Emit: 발행
 - Observable은 Event를 발행한다.
- Dispose: 처분
 - Observable은 Event발행이 Complete(완료)되면 Dispose된다.

## Event

- Obsevable은 Event를 Emit 한다.
- Observer는 Observable로 부터 Event를 Subscribe 한다.

## Dispose

- 처분한다
- dispose() 함수: 즉시 처분
- disposeBag: disposable 들을 모아놨다가 한번에 처분

## Observable 생성 방법

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

## Operator

### Transforming - Map
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

### Combination-merge
- 이벤트 타입이 같은 옵저버블 여러개를 합친다.

### Combination-zip
- 여러 옵저버블에서 이벤트를 한쌍씩 순서대로 합친다. (한쌍이 완성될 때만 발생)

### Combination-combineLatest
- 여러 옵저버블에서 가장 최근 이벤트들을 합친다.


