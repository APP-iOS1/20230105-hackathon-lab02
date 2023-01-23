# Awesome Korean Dictionary
```
어썸 코리안 딕셔너리
한국어 슬랭을 배우고 싶은 외국인을 타겟으로 만들어진 앱 
```

## 앱 스토어 다운로드 링크
<a href="https://apps.apple.com/kr/app/awesome-korean-dictionary/id1665422867">앱 스토어로 이동</a>
<br>
<br>


## 핵심 키워드
- Swift UI
- MVVM 패턴 지향
- 파파고 API
- Localization
<br>
<br>


## 화면 구성
<img src="https://user-images.githubusercontent.com/114331071/214083703-0279d45b-11aa-49d6-b227-13f216f0f43f.jpg" 
     width="1100" 
     height="600" />
<br>
<br>

## 디렉토리 구조
```AwesomeKoreanDictionary
 ┣ Assets.xcassets
 ┃ ┣ AccentColor.colorset
 ┃ ┃ ┗ Contents.json
 ┃ ┣ AppIcon.appiconset
 ┃ ┃ ┣ 1024.png
 ┃ ┃ ┗ Contents.json
 ┃ ┣ appLogo.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┗ appLogo.png
 ┃ ┣ logoColor.colorset
 ┃ ┃ ┗ Contents.json
 ┃ ┗ Contents.json
 ┣ Extension
 ┃ ┗ BundleExtension.swift
 ┣ Model
 ┃ ┣ BookmarkedVocaModel.xcdatamodeld
 ┃ ┃ ┗ BookmarkedVocaModel.xcdatamodel
 ┃ ┃ ┃ ┗ contents
 ┃ ┣ DataController.swift
 ┃ ┣ Message.swift
 ┃ ┣ User.swift
 ┃ ┗ Vocabulary.swift
 ┣ Preview Content
 ┃ ┗ Preview Assets.xcassets
 ┃ ┃ ┗ Contents.json
 ┣ Store
 ┃ ┣ AuthManager.swift
 ┃ ┣ PapagoNetworkManager.swift
 ┃ ┣ UserInfoManager.swift
 ┃ ┗ VocabularyNetworkManager.swift
 ┣ View
 ┃ ┣ AdminView
 ┃ ┃ ┣ AdminMainView.swift
 ┃ ┃ ┣ AdminView_SignInView.swift
 ┃ ┃ ┣ ApprovedView.swift
 ┃ ┃ ┣ WaitingApproveCell.swift
 ┃ ┃ ┗ WaitingApproveView.swift
 ┃ ┣ FolderMainView
 ┃ ┃ ┣ ListCell.swift
 ┃ ┃ ┣ MainView.swift
 ┃ ┃ ┣ SearchBar.swift
 ┃ ┃ ┗ SearchTestView.swift
 ┃ ┣ MyPageView
 ┃ ┃ ┣ BookmarkedWordCell.swift
 ┃ ┃ ┣ MyPageView.swift
 ┃ ┃ ┣ MyPageView_EditUserInfoView.swift
 ┃ ┃ ┣ MyPageView_MyBookmarkView.swift
 ┃ ┃ ┣ MyPageView_MyRegisterCell.swift
 ┃ ┃ ┣ MyPageView_MyRegisterView.swift
 ┃ ┃ ┣ MyPageView_SelectingLanguageView.swift
 ┃ ┃ ┣ MyPageView_SignIn.swift
 ┃ ┃ ┣ MyPageView_SignOut.swift
 ┃ ┃ ┣ PrivacyPolicyView.swift
 ┃ ┃ ┗ TermsAndConditionsView.swift
 ┃ ┣ QuizCardView
 ┃ ┃ ┣ Card.swift
 ┃ ┃ ┣ CardView.swift
 ┃ ┃ ┣ Detail.swift
 ┃ ┃ ┗ QuizView.swift
 ┃ ┣ RegistrationView
 ┃ ┃ ┗ SlangRegistrationView.swift
 ┃ ┣ ColorExtension.swift
 ┃ ┣ LoginView.swift
 ┃ ┣ MainLoadingView.swift
 ┃ ┗ SignUpView.swift
 ┣ APIInfo.plist
 ┣ AwesomeKoreanDictionary.entitlements
 ┣ AwesomeKoreanDictionaryApp.swift
 ┣ ContentView.swift
 ┣ GoogleService-Info.plist
 ┗ Info.plist
 ```



## 참여자

| <img src="https://avatars.githubusercontent.com/u/99034396?v=4" width=170> | <img src="https://avatars.githubusercontent.com/u/19788294?v=4" width=170> | <img src="https://avatars.githubusercontent.com/u/114223237?v=4" width=170> | <img src="https://avatars.githubusercontent.com/u/48899055?v=4" width=170> | <img src="https://avatars.githubusercontent.com/u/106806428?v=4" width=170> | <img src="https://avatars.githubusercontent.com/u/64416520?v=4" width=170> | <img src="https://avatars.githubusercontent.com/u/108848166?v=4" width=170> | <img src="https://avatars.githubusercontent.com/u/52193695?v=4" width=170> | <img src="https://avatars.githubusercontent.com/u/114331071?v=4" width=170> |
| :----------------------------------------------------------: | :---------------------------------------------: | :-------------------------------------------------: | :-------------------------------------------------: |  :-------------------------------------------------: |  :-------------------------------------------------: |  :-------------------------------------------------: |  :-------------------------------------------------: |  :-------------------------------------------------: |
| 태형<br/>[@yahoth](https://github.com/yahoth)<br/> | 제균<br/>[@jekyun-park](https://github.com/jekyun-park)<br/> | 소영<br/> [@primrose1101](https://github.com/primrose1101)<br/> | 주희<br/>[@zoohee](https://github.com/zoohee)<br/> | 소희<br/>[@jeongsoohee](https://github.com/jeongsoohee)<br/> | 현호<br/>[@Achoo-kr](https://github.com/Achoo-kr)<br/> | 현종<br/>[@EthanColdChoi](https://github.com/EthanColdChoi)<br/> | 진표<br/>[@jphong1005](https://github.com/jphong1005)<br/> | 유진<br/>[@yooj1202](https://github.com/yooj1202)<br/> |
