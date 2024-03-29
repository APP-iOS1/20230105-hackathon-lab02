//
//  PapagoNetworkManager.swift
//  AwesomeKoreanDictionary
//
//  Created by 박제균 on 2023/01/05.
//

import Foundation

final class PapagoNetworkManager: ObservableObject {
    enum TargetLanguage: String {
        case english = "en"
        case chinese = "zh-CN"
        case japanese = "ja"
    }

    static let shared: PapagoNetworkManager = PapagoNetworkManager()
    init() { }

    let baseURL: String = "https://openapi.naver.com/v1/papago/n2mt"
    
    // 한 -> 영 중 일
    func requestTranslate(sourceString: String, target: String) async throws -> String {
        
        let clientID = Bundle.main.CLIENT_ID
        let clinetSecret = Bundle.main.CLIENT_SECRET
        let stringWithParameters = "source=ko&target=\(target)&text=\(sourceString)"
        let data = stringWithParameters.data(using: .utf8)!
        
        guard let url = URL(string: baseURL) else { return "" }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue(clinetSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        request.httpBody = data
        
        let (responseData, _ ) = try await URLSession.shared.upload(for: request, from: data)
        let response: TranslateResponse = decodeData(responseData)
        let translatedString = response.message.result.translatedText
        
        return translatedString
    }
    
    func decodeData <T: Decodable> (_ data: Data) -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch (let error) {
            print(error)
            preconditionFailure("Fail to decode Data")
        }
    }

}
