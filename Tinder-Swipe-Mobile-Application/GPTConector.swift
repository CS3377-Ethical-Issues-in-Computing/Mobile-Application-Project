//
//  GPTConector.swift
//  Tinder-Swipe-Mobile-Application
//
//  Created by Ephraim Sun on 10/10/24.
//

import Foundation

class GPTConnector {
    private let apiKey = "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" // Replace with your OpenAI API Key

    func askGPT(question: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        
        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo", // You can also use "gpt-4"
            "messages": [
                ["role": "system", "content": "You are a helpful assistant."],
                ["role": "user", "content": "Can you explain this: \(question)?"]
            ],
            "temperature": 0.7
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Failed to serialize request body: \(error)")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to call GPT API: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received from GPT API")
                completion(nil)
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let choices = jsonResponse["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    completion(content.trimmingCharacters(in: .whitespacesAndNewlines))
                } else {
                    print("Invalid response format")
                    completion(nil)
                }
            } catch {
                print("Failed to parse GPT API response: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
