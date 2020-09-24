//
//  validation.swift
//  screenDesign
//
//  Created by Neel Gotecha on 15/10/18.
//  Copyright © 2018 Neel Gotecha. All rights reserved.
//

import UIKit

class validation: NSObject {
    
    func isEmailValid(value:String) -> Bool {
        
        print("validate emilId: \(value)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluate(with: value)
        
        print(result)
        
        return result
        
    }
    
    func isContactNumberValid(value: String) -> Bool {
        
        if value.characters.count == 10{
            
            return true
            
        }
        
        return false
        
    }
    
//    func isPasswordValid( password : String) -> Bool{
//
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
//
//        return passwordTest.evaluate(with: password)
//
//    }
//
    func isEmpty(value : String) ->Bool
        
    {
        
        if value.characters.count != 0
            {
            
                return true
            }
        
        return false
        
    }
    func isRole(value : String) -> Bool
    {
       if value == "Student"
       {
            return true
        }
        else if value == "Company"
       {
         return true
        }
        else
       {
        return false
        }
    }
}




