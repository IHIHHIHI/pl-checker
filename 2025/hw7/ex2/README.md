# HW7-2 : Exception is Sugar
## How to use
1. 구현한 `cps.ml`을 복사하거나 뼈대코드 `cps.ml.orig`을 `cps.ml`로 바꾼 후 구현합니다.
2. `./check` 명령어를 통해 테스트케이스를 실행합니다.

- `examples/test<num>.xexp` : 테스트케이스
- `examples/<test>.out` : 결과
- `examples/<test>.err` : 에러

---

> SNU 4190.310 Programming Languages

# CPS

## 컴파일 및 실행 방법

`xexp.ml`에는 xexp 언어와 그 실행기가 정의되어 있습니다.
`cps.ml` 파일에는 주어진 xexp 프로그램을 CPS(Continuation Passing Style)로 바꾸는 cps 함수가 선언되어 있고, 이 함수를 구현하는 것이 과제의 목표입니다.

아래와 같이 실행하면, 주어진 xexp 프로그램을 여러분이 작성한 변환 함수로 변환하여 실행합니다.

```sh
$ dune build --release
$ ./run examples/test1.xexp
```

실행시 파일명을 명시하지 않을 경우, 표준입력으로부터 실행코드를 읽어들입니다.
표준 입력으로 프로그램을 입력하신 후, 첫 번째 칸(column)에서 Ctrl-D 를 누르시면 프로그램이 실행됩니다.

## 변환된 프로그램 출력하기

`-pcps` 옵션을 주어 CPS 로 변환된 프로그램을 출력할 수 있습니다.

```sh
$ dune build --release
$ ./run -pcps examples/test1.xexp
```

## 숙제 제출 관련

`cps.ml` 파일에 있는 `cps` 함수를 완성하시고 그 파일만 제출해 주세요.


---
15 최재승 <jschoi@ropas.snu.ac.kr>
17 이동권 <dklee@ropas.snu.ac.kr>
18 배요한 <yhbae@ropas.snu.ac.kr>
22 박규연 <kypark@ropas.snu.ac.kr>
22 조승한 <shjo@ropas.snu.ac.kr>
24 이재호 <jhlee@ropas.snu.ac.kr>
