//
//  SlangRegistrationView.swift
//  AwesomeKoreanDictionary
//
//  Created by 정소희 on 2023/01/05.
//

import SwiftUI

struct SlangRegistrationView: View {
    
    //MARK: - 텍스트필드 작성시 사용되는 속성들
    @State private (set) var slangTextField: String = ""              //(필수) 속어
    @State private (set) var slangDescriptionTextField: String = ""   //(필수) 속어 단어 설명
    @State private (set) var slangSituationUsedTextField: String = "" //(선택) 속어 상황 재연
    
    var DescriptionExample: String = "‘농협은행 어디예요?’를 ‘너무 예쁘네요’로잘못 알아들은 썰에서 나온 신조어.‘너무 예쁘다’라는 뜻으로 쓰임"
    var SituationUsedExample: String = """
외쿡인 : 넘흐예쁘냉?
나 : 예? 아~(기대기대, 내가 쫌 예쁘지)
외쿡인 : 농협은행 어디?
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
    
    //MARK: - 국적 선택 시 사용되는 속성들
    let nationalityOptions: [String] = ["korean","english","japanese"]
    
    @State private (set) var selectednationalityIndex: Int = 0  // 국적 피커 전용 인덱스 (91번째 코드에 사용 됨)
    @State private (set) var selectednationality: String = ""   // 유저가 선택한 국적
    @State private var summitAlertToggle: Bool = false          // 공백문자 없으면 띄우는 얼럿
    @State private var summitAlertToggle2: Bool = false         // 공백문자만 있으면 띄우는 얼럿

    var body: some View {
        NavigationView {
            
            VStack{
                //MARK: - 텍스트필드 3개 (필수2, 선택1) + 국적선택 피커 1개
                Form{
                    descriptionText
                    //속어 입력 텍스트필드(필수)
                    Section{
                        Text("*필수 (공백만 입력 불가능)")
                            .font(.caption)
                            .foregroundColor(.red)
                        TextField("속어를 입력해주세요.", text: $slangTextField)
                            .font(.subheadline)
                            .padding([.top, .bottom], 30)
                        Text("예) 농협은행")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    //속어에 사용되는 단어 의미 설명 텍스트필드(필수)
                    Section{
                        Text("*필수 (공백만 입력 불가능)")
                            .font(.caption)
                            .foregroundColor(.red)
                        TextField("속어에 사용되는 단어의 의미를 설명해주세요.", text: $slangDescriptionTextField)
                            .font(.subheadline)
                            .padding([.top, .bottom],70)
                        Text("예) \(DescriptionExample)")
                            .font(.caption)
                        
                            .foregroundColor(.gray)
                    }
                    //속어가 사용되는 상활 재연(선택)
                    Section{
                        Text("*선택")
                            .font(.caption)
                            .foregroundColor(.blue)
                        TextField("속어가 사용되는 상황을 재미있게 공유해보세요!", text: $slangSituationUsedTextField)
                            .font(.subheadline)
                            .padding([.top, .bottom],70)
                        Text("예) \(SituationUsedExample)")
                            .font(.caption)
                        
                            .foregroundColor(.gray)
                        
                        
                    }
                    //국적 선택 피커
                    Section{
                        Picker("국적", selection: $selectednationalityIndex) {
                            ForEach(0..<nationalityOptions.count, id:\.self) { option in
                                Text("\(nationalityOptions[option])")
                            }
                            .onChange(of: selectednationalityIndex) { newValue in
                                self.selectednationality = nationalityOptions[selectednationalityIndex]
                            }
                        }.pickerStyle(.menu)
                    }
                    
                }
                .padding(.bottom)
                
                //MARK: - 제출하기 버튼
                if trimslangTextField.count > 0 && trimslangDescriptionTextField.count > 0{
                    VStack{
                        Button(action: {}) {
                            NavigationLink(destination: ContentView()) {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.clear)
                                        .frame(width: 350, height: 70)
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.green)
                                        .frame(width: 350, height: 60)
                                        .overlay {
                                            Text("제출하기")
                                                .foregroundColor(.white)
                                                .fontWeight(.black)
                                                .font(.title3)
                                        }
                                }
                            }
                        }
                        .alert("공유해주셔서 감사합니다!", isPresented: $summitAlertToggle) {
                            Button("Ok") {}
                        } message: {
                            Text(" 마이페이지에서 승인여부 확인 가능합니다. ")
                        }
                    }// 버튼 VStack
                } else {
                    //공백문자만 입력시 얼럿창 띄우는 코드
                    VStack{
                        Button(action: {
                            summitAlertToggle.toggle()
                        }) {
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.clear)
                                    .frame(width: 350, height: 70)
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.red)
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
                            Button("Ok") {}
                        }
                    }// 버튼 VStack
                }
                
            }//다 감싸고있는 VStack
        }
    }
}
extension SlangRegistrationView {
    //간단한 등록 설명 텍스트 (프리뷰 맨 위에 사용 됨)
    private var descriptionText: some View {
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 5){
                    
                    Text("AwesomeKoreanDictionary 에서 자신만의 단어 뜻을 넣어서 공유해보세요!")
                    
                }
                .font(.subheadline)
                Spacer()
            }
            HStack{
                VStack(alignment: .leading, spacing: 5){
                    
                    Text("많은 사람들이 보기 좋게 써주세요.")
                    Text("많은 사람들이 이 뜻을 읽고 궁금해할 수 있으니 작은 뒷 이야기도 함께 써주세요.")
                    Text("일반적으로 사용되고있는 단어의 뜻만 써주세요.")
                    Text("(개인적인 농담과 관련된 단어의 뜻은 거부 할 것입니다.)")
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                }
                .font(.subheadline)
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