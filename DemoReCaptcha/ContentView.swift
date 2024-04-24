//
//  ContentView.swift
//  DemoReCaptcha
//
//  Created by Dmitrii Gordienko on 23.04.2024.
//

import SwiftUI
import RecaptchaEnterprise

struct ContentView: View {
    @ObservedObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            Text("reCAPTCHA enterprise")
            
            Button {
                viewModel.execute()
            } label: {
                Text("Execute")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
