//
//  SlangRegistrationView.swift
//  AwesomeKoreanDictionary
//
//  Created by 정소희 on 2023/01/05.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn

struct SlangRegistrationView: View {
    @ObservedObject var vocaManager: VocabularyNetworkManager = VocabularyNetworkManager()
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.dismiss) private var dismiss
    
    //MARK: - 텍스트필드 작성시 사용되는 속성들
    @State private (set) var slangTextField: String = "" //(필수) 속어
    @State private (set) var slangDescriptionTextField: String = "" //(필수) 속어 단어 설명
    @State private (set) var slangSituationUsedTextField: String = "" //(선택) 속어 상황 재연
    @State private (set) var slangPronunciationTextField: String = "" //(선택) 속어 발음
    
    var DescriptionExample: String = "외국인의 ‘농협은행 어디예요?’라는 발음을 한국 사람이 ‘너무 예쁘네요’로 잘못 알아들은 썰에서 나온 신조어.‘너무 예쁘다’라는 뜻으로 쓰임."
    var SituationUsedExample: String = """
외국인 : 넘흐예쁘냉?
나 : 예? 아~(기대기대, 내가 쫌 예쁘지)
외국인 : 농협은행 어디?
나 : 아..ㅋㅋㅋㅋ..
"""
    //속어 입력 텍스트필드 공백체크
    private var trimslangTextField: String {
        slangTextField.trimmingCharacters(in: .whitespaces)
    }
    //속어 단어의미 설명 텍스트필드 공백체크
    private var trimslangDescriptionTextField: String {
        slangDescriptionTextField.trimmingCharacters(in: .whitespaces)
    }
    //속어 상황 재연 텍스트필드 공백체크
    private var trimslangSituationUsedTextField: String {
        slangSituationUsedTextField.trimmingCharacters(in: .whitespaces)
    }
    //속어 발음 텍스트필드 공백체크
    private var trimslangPronunciationTextField: String {
        slangPronunciationTextField.trimmingCharacters(in: .whitespaces)
    }
    
    @State private var summitAlertToggle: Bool = false // 공백문자 없으면 띄우는 얼럿
    @State private var summitAlertToggle2: Bool = false // 공백문자만 있으면 띄우는 얼럿
    
    //정규식 사용해보려고했는데.. 아직 사용목했습니다.
    private func nameValidation(text: String) -> Bool {
        // String -> Array
        let arr = Array(text)
        // 정규식 pattern. 한글, 영어, 숫자, 밑줄(_)만 있어야함
        let pattern = "^[ㄱ-ㅎㅏ-ㅣ가-힣]$"
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            var index = 0
            while index < arr.count { // string 내 각 문자 하나하나 마다 정규식 체크 후 충족하지 못한것은 제거.
                let results = regex.matches(in: String(arr[index]), options: [], range: NSRange(location: 0, length: 1))
                if results.count == 0 {
                    return false
                } else {
                    index += 1
                }
            }
        }
        return true
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if authManager.state == .signedIn {
                    //MARK: - 텍스트필드 3개 (필수2, 선택1) + 국적선택 피커 1개
                    Form {
                        descriptionText
                        //속어 입력 텍스트필드(필수)
                        Section {
                            Text("* 필수 (공백만 입력 불가능)")
                                .font(.caption)
                                .foregroundColor(Color(hex: "ff598e"))
                            TextField("신조어/속어의 의미와 유래를 설명해주세요.", text: $slangTextField)
                                .font(.title3)
                                .fontWeight(.bold)
                                .lineLimit(1, reservesSpace: true)
                                .frame(width: 320, height: 30, alignment: .top)
                            Text("예) 농협은행")
                                .font(.caption)
                                .foregroundColor(.gray)

                        }
                        //속어 발음 입력 텍스트필드(필수)
                        Section {
                            Text("* 영어 필수 문항 (한글, 공백만 입력 불가능)")
                                .font(.caption)
                                .foregroundColor(.red)
                            TextField("신조어/속어가 사용되는 상황을 \n'예문'으로 재미있게 공유해주세요!", text: $slangPronunciationTextField)
                                .font(.title3)
                                .fontWeight(.bold)
                                .lineLimit(1, reservesSpace: true)
                                .frame(width: 320, height: 30, alignment: .top)
                            Text("예시) Nonghyupeunhaeng")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        //속어에 사용되는 단어 의미 설명 텍스트필드(필수)
                        Section {
                            Text("* 필수 (공백만 입력 불가능)")
                                .font(.caption)
                                .foregroundColor(.red)
                            TextField("신조어/속어의 의미와 유래를 설명해주세요.", text: $slangDescriptionTextField, axis: .vertical)
                                .font(.subheadline)
                                .lineLimit(7, reservesSpace: true)
                                .frame(width: 320, height: 150, alignment: .top)
                            
                            Text("예시) \(DescriptionExample)")
                                .font(.caption)
                            
                                .foregroundColor(.gray)
                        }
                        //속어가 사용되는 상활 재연(선택)
                        Section {
                            Text("*필수 (공백만 입력 불가능)")
                                .font(.caption)
                                .foregroundColor(.red)
                            TextField("신조어/속어가 사용되는 상황을 \n'예문'으로 재미있게 공유해주세요!", text: $slangSituationUsedTextField, axis: .vertical)
                                .font(.subheadline)
                                .lineLimit(7, reservesSpace: true)
                                .frame(width: 320, height: 150, alignment: .top)
                            Text("예시) \(SituationUsedExample)")
                                .font(.caption)
                            
                                .foregroundColor(.gray)
                            
                            
                        }
                    }
                    .padding(.bottom)
                    
                    //MARK: - 제출하기 버튼
                    if trimslangTextField.count > 0 && trimslangDescriptionTextField.count > 0 && trimslangSituationUsedTextField.count > 0 && trimslangPronunciationTextField.count > 0 {
                        VStack {
                            Button {
                                Task {
                                    await vocaManager.createVoca(voca: Vocabulary(id: UUID().uuidString, word: slangTextField, pronunciation: "", definition: slangDescriptionTextField, example: slangSituationUsedTextField, likes: 0, dislikes: 0, creatorId: Auth.auth().currentUser?.uid ?? ""))
                                    
                                    summitAlertToggle.toggle()
                                    
                                    print(Vocabulary(id: UUID().uuidString, word: slangTextField, pronunciation: "", definition: slangDescriptionTextField, example: slangSituationUsedTextField, likes: 0, dislikes: 0, creatorId: Auth.auth().currentUser?.uid ?? ""))
                                }
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.clear)
                                        .frame(width: 350, height: 70)
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "737DFE"))
                                        .frame(width: 350, height: 60)
                                        .overlay {
                                            Text("제출하기")
                                                .foregroundColor(.white)
                                                .fontWeight(.black)
                                                .font(.title3)
                                        }
                                }
                            }
                            .alert("공유해주셔서 감사합니다!", isPresented: $summitAlertToggle) {
                                Button("Ok") { dismiss() }
                            } message: {
                                Text(" 마이페이지에서 승인여부 확인 가능합니다. ")
                            }
                        }
                    } else {
                        //공백문자만 입력시 얼럿창 띄우는 코드
                        VStack {
                            Button(action: {
                                summitAlertToggle2.toggle()
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.clear)
                                        .frame(width: 350, height: 70)
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.gray)
                                        .frame(width: 350, height: 60)
                                        .overlay {
                                            Text("제출하기")
                                                .foregroundColor(.white)
                                                .fontWeight(.black)
                                                .font(.title3)
                                        }
                                }
                            }
                            .alert("필수문항을 모두 입력해주세요.", isPresented: $summitAlertToggle2) {
                                Button("Ok") { }
                            }
                        }
                    }
                } else {
                    LoginView()
                }
            }
        }
    }
}

extension SlangRegistrationView {
    //간단한 등록 설명 텍스트 (프리뷰 맨 위에 사용 됨)
    private var descriptionText: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("새로운 신조어/속어를 공유해주세요!")
                }
                .font(.title3)
                .bold()
                Spacer()
            }
            .padding(5)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Awesome Korean Dictionary는 외국인을 위한 한국어 신조어/속어 사전입니다. 한글로 내용을 작성해 주시면, 번역 기능을 사용해 외국인이 쉽게 볼 수 있습니다.")
                    Text("해당 단어의 의미와 유래, 예문을 함께 작성해 주시면 외국인의 단어 이해에 큰 도움이 됩니다!")

                    Text("등록해 주신 단어는 관리자의 검수 및 승인 이후 노출되며,\n최종 등록까지 최대 3일이 소요될 수 있습니다.")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(.vertical,5)
                }
                .font(.subheadline)
                .padding(5)
                Spacer()
            }
        }
    }
}

struct SlangRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        SlangRegistrationView()
    }
}
