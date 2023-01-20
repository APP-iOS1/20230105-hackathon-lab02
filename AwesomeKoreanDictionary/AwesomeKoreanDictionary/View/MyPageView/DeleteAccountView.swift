//
//  DeleteAccountView.swift
//  AwesomeKoreanDictionary
//
//  Created by 박제균 on 2023/01/19.
//

import SwiftUI

struct DeleteAccountView: View {

    enum deleteReasons: String, CaseIterable, Identifiable {
        var id: Self { self }
        
        case missing = "내가 찾는 단어가 없음"
        case insufficientLanguageSupport = "앱 내의 지원언어 부족"
        case inaccurateData = "앱 내의 단어 정보가 부정확함"
        case etc = "기타"
    }

    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var userInfoManager: UserInfoManager
    @State private var deleteReason: String = deleteReasons.missing.rawValue
    @State private var isPresentConfirmationDialog = false

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text("탈퇴시 다른 사람들을 위해 한국어 단어를 공유할 수 없어요")
                .font(.body)
            
                Text("탈퇴 이유를 선택해주세요")
            
                Picker("계정 삭제 이유를 선택해주세요", selection: $deleteReason) {
                    ForEach(deleteReasons.allCases) { reason in
                        Text(reason.rawValue).tag(reason.rawValue)
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity)
            
            Button(role: .destructive) {
                isPresentConfirmationDialog.toggle()

            } label: {
                Text("탈퇴하기")
            }
            .frame(maxWidth: .infinity)
            .confirmationDialog("확인을 누르시면 계정을 삭제합니다.", isPresented: $isPresentConfirmationDialog) {
                Button("계정 탈퇴하기", role: .destructive) {
                    userInfoManager.deleteUser(id: userInfoManager.userInfo!.id)
                    authManager.deleteUser()
                    dismiss()
                }
            } message: {
                Text("계정을 탈퇴하면 되돌릴 수 없습니다.")
            }

        }
        .navigationTitle("정말 탈퇴 하시겠습니까?")
        .navigationBarTitleDisplayMode(.large)
            .padding()
    }
}

struct DeleteAccountView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountView()
            .environmentObject(AuthManager())
            .environmentObject(UserInfoManager())
    }
}
