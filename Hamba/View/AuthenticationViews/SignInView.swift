//
//  SignInView.swift
//  Hamba
//
//  Created by Alexander Görtzen on 04.06.24.
//

import SwiftUI

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "tree")
                    .font(.system(size: 100))
                    .foregroundColor(.green)
                    .symbolRenderingMode(.palette)
                    .symbolEffect(.bounce, options: .speed(0.1), value: true)

                Text("Hamba")
                    .padding()
                    .font(.system(size: 50, weight: .heavy, design: .serif))
                    .animation(Animation.smooth(duration: 3, extraBounce: 2.0).delay(1.5), value: true)

                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Button {
                    signIn()
                } label: {
                    Text("Sign In")
                        .padding()
                        .background(Color.darkGreen)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Spacer()

                HStack {
                    Text("New to Hamba? Feel free to sign up!")
                    Spacer()

                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .padding()
                            .background(Color.darkGreen)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .padding()
        }
    }

    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                // User signed in successfully
            }
        }
    }
}

#Preview {
    SignInView()
}
