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
    //(필수) 속어
    @State private (set) var slangTextField: String = ""
    //(필수) 속어 단어 설명
    @State private (set) var slangDescriptionTextField: String = ""
    //(선택) 속어 상황 재연
    @State private (set) var slangSituationUsedTextField: String = ""
    //(선택) 속어 발음
    @State private (set) var slangPronunciationTextField: String = ""
    
    var descriptionExample: String = "'Case by case'의 줄임말. 어떤 규칙이 꼭 모든 상황에 공통되게 적용되지 않고 때에 따라 다르다는 것을 이르는 말."
    var situationUsedExample: String = "교수님이 좀 바쁘셔서, 수업을 일찍 끝낼 때도 있고 아닐 때도 있어. 케바케야."
    
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
    // 공백문자 없으면 띄우는 얼럿
    @State private var haveNoBlank: Bool = false
    // 공백문자만 있으면 띄우는 얼럿
    @State private var isOnlyWithBlank: Bool = false
    @State private var isKorean: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if authManager.state == .signedIn {
                    //MARK: - 텍스트필드 4개
                    Form {
                        descriptionText
                        //속어 입력 텍스트필드(필수)
                        Section {
                            
                            Text("* 한글로 입력해주세요. (영단어 입력 불가)")
                                .font(.caption)
                                .foregroundColor(Color(hex: "ff598e"))
                            TextField("신조어를 입력해주세요.", text: $slangTextField)
                                .font(.title3)
                                .fontWeight(.bold)
                                .lineLimit(1, reservesSpace: true)
                                .frame(width: 320, height: 30, alignment: .top)
                            Text("예) 케바케")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                        }
                        //속어 발음 입력 텍스트필드(필수)
                        Section {
                            Text("* 영어로 입력해주세요.")
                                .font(.caption)
                                .foregroundColor(Color(hex: "ff598e"))
                            TextField("신조어의 발음을 알파벳으로 입력해 주세요.", text: $slangPronunciationTextField)
                                .font(.callout)
                                .fontWeight(.bold)
                                .lineLimit(1, reservesSpace: true)
                                .frame(width: 320, height: 30, alignment: .top)
                            Text("예시) kebake")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        //속어에 사용되는 단어 의미 설명 텍스트필드(필수)
                        Section {
                            
                            Text("* 한글로 입력해주세요.")
                                .font(.caption)
                                .foregroundColor(Color(hex: "ff598e"))
                            TextField("신조어의 의미와 유래를 설명해주세요.", text: $slangDescriptionTextField, axis: .vertical)
                                .font(.subheadline)
                                .lineLimit(7, reservesSpace: true)
                                .frame(width: 320, height: 150, alignment: .top)
                            
                            Text("예시) \(descriptionExample)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        //속어가 사용되는 상활 재연(필수)
                        Section {
                            Text("* 한글로 입력해주세요.")
                                .font(.caption)
                                .foregroundColor(Color(hex: "ff598e"))
                            TextField("신조어가 실제로 사용되는 상황을 \n'예문'으로 재미있게 공유해주세요!", text: $slangSituationUsedTextField, axis: .vertical)
                                .font(.subheadline)
                                .lineLimit(7, reservesSpace: true)
                                .frame(width: 320, height: 150, alignment: .top)
                            Text("예시) \(situationUsedExample)")
                                .font(.caption)
                            
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.bottom)
                    
                    //MARK: - 제출하기 버튼
                    if trimslangTextField.count > 0 &&
                        trimslangDescriptionTextField.count > 0 &&
                        trimslangSituationUsedTextField.count > 0 &&
                        trimslangPronunciationTextField.count > 0 {
                        VStack {
                            Button {
                                Task {
                                    if KonameValidation(text: trimslangTextField) &&
                                        KonameValidation(text: trimslangDescriptionTextField) &&
                                        KonameValidation(text: trimslangSituationUsedTextField) &&
                                        EnnameValidation(text: trimslangPronunciationTextField) {
                                        await vocaManager.createVoca(voca:
                                                                        Vocabulary(
                                                                            id: UUID().uuidString, word: trimslangTextField,
                                                                            pronunciation: slangPronunciationTextField,
                                                                            definition: trimslangDescriptionTextField,
                                                                            example: trimslangSituationUsedTextField,
                                                                            likeArray: [],
                                                                            dislikeArray: [],
                                                                            creatorId: authManager.currentUserInfo.id))
                                        
                                        isKorean = true
                                        
                                    } else {
                                        isKorean = false
                                    }
                                    haveNoBlank.toggle()
                                    
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
                            .alert(isKorean ? "공유해 주셔서 감사합니다!" : "필수 항목을 다시 한 번 확인해주세요.", isPresented: $haveNoBlank) {
                                Button("Ok") {
                                    if isKorean {
                                        dismiss()
                                    }
                                }
                            } message: {
                                Text(isKorean ? "단어 승인여부는 마이페이지에서 확인 가능합니다." : "")
                            }
                        }
                    } else {
                        VStack {
                            Button(action: {
                                isOnlyWithBlank.toggle()
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
                            .alert("필수 문항을 모두 입력해주세요.", isPresented: $isOnlyWithBlank) {
                                Button("OK") { }
                            }
                        }
                    }
                } else {
                    LoginView()
                }
            }
            .padding(.top, -20)
        }
    }
    func KonameValidation(text: String) -> Bool {
        let pattern = "^[가-힣ㄱ-ㅎㅏ-ㅣ\\t\\n\\r\\f\\v\\s]*$"
        let textTest = text.range(of: pattern, options: .regularExpression) != nil
        return textTest
    }
    
    func EnnameValidation(text: String) -> Bool {
        let pattern = "^[a-zA-Z\\t\\n\\r\\f\\v\\s]*$"
        let textTest = text.range(of: pattern, options: .regularExpression) != nil
        return textTest
    }
}

extension SlangRegistrationView {
    private var descriptionText: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("새로운 신조어를 공유해주세요!")
                }
                .font(.title3)
                .bold()
                Spacer()
            }
            .padding(5)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("'Awesome Korean Dictionary'는 외국인을 위한 한국어 신조어&속어 사전입니다. 한글로 내용을 작성해 주시면, 번역 기능을 사용해 외국인이 쉽게 볼 수 있습니다.")
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
            .environmentObject(AuthManager())
    }
}
