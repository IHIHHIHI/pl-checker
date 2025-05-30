# HW8-2 : Rozetta
## How to use
1. 구현한 `rozetta.ml`을 복사하거나 뼈대코드 `rozetta.ml.orig`을 `rozetta.ml`로 바꾼 후 구현합니다.
2. `./check` 명령어를 통해 테스트케이스를 실행합니다.

- `examples/test<num>.sm5` : 테스트케이스
- `examples/test<num>.k--` : 테스트케이스 (k-- 버전)
- `examples/test<num>.in`  : (입력이 필요한 경우만) 입력
- `examples/test<num>.ans` : 정답
- `examples/test<num>.out` : 출력

**hard testcase**

k--를 번역하지 않고 직접 임의로 작성한 sm5 코드입니다. 점수에 영향이 없을지도 모릅니다.
- `examples/test_hard<num>.*`

---

> SNU 4190.310 Programming Languages

# RozettaX

## 컴파일 및 실행 방법

`sm5.ml`에는 SM5 언어와 실행기, `sonata.ml`에는 Sonata 언어와 실행기가 정의되어 있습니다.
아래와 같이 실행하면, 주어진 SM5 프로그램을 여러분이 작성하신 RozettaX 번역기에 따라 번역하고 Sonata 기계로 실행합니다.

```sh
make
./run examples/test1.sm5
```

## SM5 기계로 실행하기

주어진 SM5 프로그램을 SM5 기계로 실행한 결과를 다음과 같이 확인할 수 있습니다.
번역이 제대로 되었다면, Sonata 기계로 실행한 결과와 SM5 기계로 실행한 결과가 같아야 합니다.

```sh
./run -sm5 examples/test1.sm5
```

## 번역된 Sonata 프로그램 출력하기

주어진 SM5 프로그램을 Sonata로 번역한 결과를 `-psonata` 옵션을 통해 출력할 수 있습니다.

```sh
./run -psonata examples/test1.sm5
```

## SM5/Sonata 기계 위에서 디버그 모드로 실행하기

주어진 프로그램을 SM5나 Sonata 기계로 실행할 때, 매 스텝마다 기계 상태를 출력합니다.

```sh
./run -debug examples/test1.sm5
```

## 숙제 제출 관련

`rozettax.ml` 파일에 있는 `trans` 함수를 완성하시고 그 파일만 제출해 주세요.

---
최웅식 <wschoi@ropas.kaist.ac.kr>
신재호 <netj@ropas.snu.ac.kr>
김덕환 <dk@ropas.snu.ac.kr>
오학주 <pronto@ropas.snu.ac.kr>
박대준 <pudrife@ropas.snu.ac.kr>
이희종 <ihji@ropas.snu.ac.kr>
정영범 <dreameye@ropas.snu.ac.kr>
오학주 <pronto@ropas.snu.ac.kr>
허기홍 <khheo@ropas.snu.ac.kr>
조성근 <skcho@ropas.snu.ac.kr>
윤용호 <yhyoon@ropas.snu.ac.kr>
김진영 <jykim@ropas.snu.ac.kr>
최재승 <jschoi@ropas.snu.ac.kr>
이동권 <dklee@ropas.snu.ac.kr>
배요한 <yhbae@ropas.snu.ac.kr>
