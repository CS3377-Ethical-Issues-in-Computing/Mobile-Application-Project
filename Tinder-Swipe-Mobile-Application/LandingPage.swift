//
//  LandingPage.swift
//  Tinder-Swipe-Mobile-Application
//
//  Created by Ephraim Sun on 10/10/24.
//

import SwiftUI

import SwiftUI

struct LandingPage: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false // Track login status

    var body: some View {
        NavigationView {
            VStack {
                if !isLoggedIn {
                    // Login Form
                    Text("Login")
                        .font(.largeTitle)
                        .padding()

                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: {
                        // Handle login action
                        // For now, just simulate a successful login
                        isLoggedIn = true
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding()

                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot Password?")
                            .foregroundColor(.blue)
                    }
                    .padding()

                } else {
                    // Buttons after logging in
                    Text("Welcome, \(username)!")
                        .font(.title)
                        .padding()

                    NavigationLink(destination: AboutUsPage()) {
                        Text("About Us")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding()

                    NavigationLink(destination: SwipeView()) {
                        Text("Start Asking Questions")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                    .padding()
                }

                Spacer()
            }
            .padding()
        }
    }
}

struct ForgotPasswordView: View {
    var body: some View {
        Text("Forgot Password Page")
            .font(.title)
    }
}
