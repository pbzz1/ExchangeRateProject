# ExchangeRateProject
YouTube 발표 동영상 링크: 
[(https://youtu.be/ajhvT1GRwoJw6S8u)](https://www.youtube.com/watch?v=1vob6_6BVtw)

Main.storyboard 구성
<img width="1119" alt="스크린샷 2024-06-19 오후 6 19 48" src="https://github.com/pbzz1/ExchangeRateProject/assets/118409477/5f9caa2d-5205-4276-ab8d-b200e7c1cfc4">
위 보이는 그림과 같이 Main.storyboard는 
textfield: 1
PicerView: 2
ImageLabel: 1
Button: 1
Label: 1
로 구성하였습니다.

ViewController.swift
<img width="733" alt="스크린샷 2024-06-19 오후 6 23 13" src="https://github.com/pbzz1/ExchangeRateProject/assets/118409477/d54991dc-7e90-4625-aff7-ca5c00ae03eb">
URL Session을 통해 API에서 환율 데이터를 가져옵니다.
또한 환율 데이터를 저장할 모델 클래스를 생성합니다.

<img width="1000" alt="스크린샷 2024-06-19 오후 6 27 40" src="https://github.com/pbzz1/ExchangeRateProject/assets/118409477/96af08a9-9758-4cdf-ad2a-8c17d8b4b72e">
UI 요소에 대한 처리를 해주고 액션에 대한 처리를 해줍니다.
