> [en](./README.en.md)

# Dart Code Generation

> devfest 2022, GDG Songdo 발표 자료 입니다.

플러터의 언어로 사용되는 다트의 빌드 시스템을 활용하여 코드를 생성하는
방법에 대한 예제 프로젝트입니다.

## 예제 실행 방법

예제를 정상적으로 실행하기 위해선
[melos](https://melos.invertase.dev/getting-started)를 먼저 설치해야 합니다.

```bash
# melos 설치를 하셨다면 첫 커맨드는 생략해도 됩니다.
$> dart pub global activate melos # 혹은 위의 melos 링크를 참조하세요
$> melos bs
```

이후에 원하는 패키지가 있는 디렉토리로 가서, dart 혹은 flutter 명령어들을
실행해보세요!

## 프로젝트 구성

- `packages` 디렉토리에 필요한 패키지들이 위치합니다.
  - `packages/annotations` 패키지에 사용할 어노테이션이 정의되어 있습니다.
  - `packages/generators` 패키지에 코드 생성기가 정의되어 있습니다드
