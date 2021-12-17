//
//  Login.swift
//  Real Estate App
//
//  Created by arifashraf on 08/12/21.
//

import SwiftUI

struct LoginView: View
{
    
    @ObservedObject var loginVM = LoginViewModel()
    
    var body: some View
    {
        NavigationView
        {
            ScrollView
            {
                //MARK: Custom Entry Field
                //                                EntryField(sfSymbolName: Constants.TextField.personSymbol, placeHolder: "Enter A Name", prompt: loginVM.emailPrompt, field: $loginVM.email)
                //
                //                                EntryField(sfSymbolName: Constants.TextField.passwordSymbol, placeHolder: "Enter A Password", prompt: loginVM.passwordPrompt, field: $loginVM.password, isSecure: true)
                //                CheckboxFieldView()
                
                VStack
                {
                    Text("Login")
                        .padding()
                    VStack(alignment: .leading, spacing: 8, content:
                            {
                        Text("User Name")
                            .foregroundColor(.gray)
                        HStack
                        {
                            Image(systemName: "person")
                            TextField("Enter User Name", text: $loginVM.email)
                                .foregroundColor(Color.black)
                                .textInputAutocapitalization(.never)
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 0)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.gray))
                    })
                        .padding()
                    VStack(alignment: .center, spacing: 8, content:
                            {
                        HStack
                        {
                            Text("Password")
                                .foregroundColor(.gray)
                            Button(action: {}, label:
                                    {
                                Text("Forgot Password?")
                            })
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(Color("CustomDarkBlue"))
                        }
                        HStack
                        {
                            Image(systemName: "lock")
                            SecureField("Enter Password",text: $loginVM.password    )
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 0)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.gray))
                        CheckboxFieldView()
                    })
                        .padding()
                    
                    
                    
                    NavigationLink(destination: HomeView(),
                                   isActive: self.$loginVM.isLoginValid)
                    {
                        Text("SIGN IN")
                            .padding()
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("CustomDarkBlue"))
                            .onTapGesture
                        {
                            //determine login validity
                            let isLoginValid = self.loginVM.email == Credentials().username && self.loginVM.password == Credentials().password
                            
                            //trigger logic
                            if isLoginValid {
                                self.loginVM.isLoginValid = true //trigger NavigationLink
                                loginVM.logIn()
                            }
                            else {
                                self.loginVM.shouldShowLoginAlert = true //trigger Alert
                            }
                        }
                    }
                    .padding([.leading, .trailing], 15)
                    .alert(isPresented: $loginVM.shouldShowLoginAlert) {
                        Alert(title: Text("Email/Password incorrect"))
                    }
                    
                    Divider()
                        .padding([.leading, .trailing], 15)
                        .padding(.top, 20)
                    
                    VStack(alignment: .center, spacing: 8)
                    {
                        Text("New to the System?")
                            .frame(width: 186, height: 23, alignment: .center)
                            .foregroundColor(Color.gray)
                        NavigationLink(destination: SignUpView(), label:
                                        {
                            Text("SIGN UP NOW")
                                .padding()
                                .foregroundColor(Color("CustomDarkBlue"))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .border(Color.gray)
                        })
                    }
                    .padding([.leading, .trailing, .bottom], 15)
                }
            }
        }
        .environment(\.horizontalSizeClass, .compact)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .previewDevice("iPhone 11")
                .previewInterfaceOrientation(.portrait)
            LoginView()
                .previewDevice("iPhone SE (2nd generation)")
                .previewInterfaceOrientation(.portrait)
            LoginView()
                .previewDevice("iPhone 8")
                .previewInterfaceOrientation(.portrait)
        }
    }
}
