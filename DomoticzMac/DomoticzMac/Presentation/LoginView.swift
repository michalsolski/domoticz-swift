//
//  LoginView.swift
//  DomoticzMac
//
//  Created by Michał Solski on 31/03/2021.
//

import SwiftUI
import DomoticzSwift

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    
    @State var host: String = ""
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            TextField("host", text: $host)
            TextField("username", text: $username)
            TextField("password", text: $password)
            Button("login") {
                viewModel.login(host: host, user: username, password: password)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
