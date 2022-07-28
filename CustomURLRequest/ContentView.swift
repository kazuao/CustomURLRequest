//
//  ContentView.swift
//  CustomURLRequest
//
//  Created by kazunori.aoki on 2022/07/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }

    func request() {

        let baseURL = URL(string: "https://example.com")!

        // パターン1
        let _ = RequestBuilder(path: "users/search")
            .queryItems([
                URLQueryItem(name: "city", value: "San Francisco")
            ])
            .makeRequest(withBaseURL: baseURL)
        // https://example.com/users/search?city=San%20Francisco

        // パターン2
        let _ = RequestBuilder(path: "users/search")
            .queryItem(name: "city", value: "San Francisco")
            .queryItem(name: "maxResults", value: 100.description)
            .makeRequest(withBaseURL: baseURL)
        // https://example.com/users/search?city=San%20Francisco&maxResults=100

        // パターン3
        let userForm = UserForm(name: "ほげほげ")
        do {
            let _ = try RequestBuilder(path: "users/submit")
                .method(.post)
                .jsonBody(userForm)
                .contentType(.applicationJSON)
                .accept(.applicationJSON)
                .timeout(20)
                .queryItem(name: "city", value: "San Francisco")
                .header(name: "Auth-Token", value: "authToken")
                .makeRequest(withBaseURL: baseURL)
        } catch {
            print("Error: ", error.localizedDescription)
        }
    }
}

struct UserForm: Codable {
    var name: String
}
