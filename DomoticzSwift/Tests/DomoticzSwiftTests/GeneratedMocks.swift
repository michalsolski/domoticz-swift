// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


//To regenerate this file, go to directory "Scripts" and run "generateMocks.sh"
import Foundation
import Combine
@testable import DomoticzSwift
class AuthenticationDataStorageMock: NSObject, AuthenticationDataStorage {


var authenticationData: AuthenticationData?

@Published var _authenticationDataPubliser: AuthenticationData?
var authenticationDataPubliser: Published<AuthenticationData?>.Publisher { $_authenticationDataPubliser } 


}


class HttpClientMock: NSObject, HttpClient {

//MARK: - call
var call_returnValue: AnyPublisher<HttpResponse, Error> = AnyPublisher<HttpResponse, Error>()
var call_called = false
var call_call_count = 0
var call_params_Request: (HttpRequest)?

func call(request: HttpRequest)   -> AnyPublisher<HttpResponse, Error> {
call_called = true
call_call_count += 1
call_params_Request = request
return call_returnValue 
}
}


class LoginInteractorMock: NSObject, LoginInteractor {

//MARK: - login
var login_returnValue: AnyPublisher<Void, Error> = AnyPublisher<Void, Error>()
var login_called = false
var login_call_count = 0
var login_params: (server: String, username: String, password: String)?

func login(server: String, username: String, password: String)   -> AnyPublisher<Void, Error> {
login_called = true
login_call_count += 1
login_params = (server: server, username: username, password: password)
return login_returnValue 
}
}


class UserStateInteractorMock: NSObject, UserStateInteractor {

@Published var _isUsserLoggedPublisher: Bool = Bool() 
var isUsserLoggedPublisher: Published<Bool>.Publisher { $_isUsserLoggedPublisher } 


//MARK: - logout
var logout_called = false
var logout_call_count = 0

func logout()   {
logout_called = true
logout_call_count += 1
}
}



