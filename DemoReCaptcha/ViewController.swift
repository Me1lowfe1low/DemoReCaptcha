//
//  ViewController.swift
//  DemoReCaptcha
//
//  Created by Dmitrii Gordienko on 23.04.2024.
//

import UIKit
import RecaptchaEnterprise

@MainActor class ViewModel: ObservableObject {
    private var recaptchaClient: RecaptchaClient?
    
    init() {
        Task {
            do {
                let client = try await Recaptcha.getClient(
                    withSiteKey: "XXXXXXXXXXXXXXXXXXXX-XX-XXXXXXXXXXXXXXXX"
                )
                
                self.recaptchaClient = client
            } catch let error as RecaptchaError {
                print("RecaptchaClient creation error: \(String(describing: error.errorMessage)).")
            }
        }
    }
    
    func execute() {
        guard let recaptchaClient = self.recaptchaClient else {
            print("Client not initialized correctly.")
            
            return
        }
        
        // Instead of using "example_action" we could use hashFunction to encode action here and decode it at the backend: response.token_properties.action and then check it
        Task {
            do {
                let token = try await recaptchaClient.execute(
                    withAction: RecaptchaAction.init(customAction: "example_action")
                )
                
                sendPostRequestToLocalServer(with: token)
//                print(token)
            } catch let error as RecaptchaError {
                print(error.errorMessage)
            }
        }
    }
    
    private func sendPostRequestToLocalServer(with token: String) {
        let port = "5001"
        let host = "127.0.0.1"
        let url = URL(string: "http://\(host):\(port)/post")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonDictionary: [String: String] = ["token": token]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary) else {
            print("Failed to convert JSON dictionary to data")
            return
        }
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Handle response
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
                // Handle data returned in 'data'
            }
        }

        task.resume()
    }
}
