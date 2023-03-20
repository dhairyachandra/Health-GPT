//
//  OpenAIService.swift
//  HealthGPT
//
//  Created by Dhairya Chandra on 3/15/23.
//

import Foundation
import Alamofire
import Combine
class OpenAIService {
    let baseURL = "https://api.openai.com/v1/"
    
    func sendMessage(message: String) -> AnyPublisher<OpenAICompletionResponse, Error> {
        let body = OpenAICompletionsBody(model: "text-davinci-003", prompt: message, temperature: 0.7, max_tokens: 256)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAIAPIKey)"
        ]
        
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            AF.request(self.baseURL + "completions", method: .post, parameters: body, encoder: .json,
                       headers: headers).responseDecodable(of: OpenAICompletionResponse.self) { response in
                switch response.result {
                case .success(let result):
                    promise(.success(result))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    }

struct OpenAICompletionsBody: Encodable{
    let model: String
    let prompt: String
    let temperature: Float?
    let max_tokens: Int
}

struct OpenAICompletionResponse: Decodable{
    let id: String
    let choices: [OpenAICompletionsChoice]
    
}

struct OpenAICompletionsChoice: Decodable {
    let text: String
}
