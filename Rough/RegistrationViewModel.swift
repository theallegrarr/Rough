//
//  RegistrationViewModel.swift
//  Rough
//
//  Created by nurudeen on 05/06/2021.
//

import Foundation

class RegistrationViewModel {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    
    init(firstName: String, lastName: String, email: String, password: String){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
}
