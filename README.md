# RxSwift 학습
## RxSwift를 정리하고 학습 하는 공간입니다.
###RxSwift 이론을 학습하며 기능들을 사용해보고 간단한 미니프로젝트를 만들 계획입니다.

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

***참고사이트 출처:*** <https://medium.com/ios-forever/rxswift-%EA%B8%B0%EB%B3%B8-%EC%9D%B5%ED%9E%88%EA%B8%B0-1-d4d77ce63ca8>

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

##Observable 생성 방법

- just: Element를 1개 Emit 한다.
- subscribe를 미리 지정
- from: Element를 Array로 보내고 하나씩 Emit한다.
- of: 
- empty
- never
- error
- create
- repeatElement
- interval