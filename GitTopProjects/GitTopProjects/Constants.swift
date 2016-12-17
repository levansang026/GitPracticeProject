//
//  Constants.swift
//  GitTopProjects
//
//  Created by bill on 12/15/16.
//  Copyright © 2016 bill. All rights reserved.
//

import Foundation

struct Constants{
    
    enum LanguageType: Int{
        case Swift = 0
        case C
        case Java
        case Python
        case PHP
    }
    
    struct GAPI{
        static let ApiScheme = "https"
        static let ApiHost = "api.github.com"
        //static let ApiPath = "/3"

    }
    
    struct GitAPIParameterKeys{
        static let ClientID = "client_id"
        static let ClientSecretID = ""
        static let Scope = "scope"
        static let RedirectURL = "redirect_uri"
        static let State = "state"
        static let AllowSignUp = "allow_signup"
        static let AuthCode = "code"
        static let SearchQuery = "q"
        
        static let Sort = "sort"
        static let Order = "order"
    }
    
    struct GitAPIParameterValues{
        static let ClientID = "73329d9d1f0a95377d2c"
        static let ClientSrecretID = "fb6941ae58bade59f0044362782befbb3efd4356"
        static let SwiftLanguage = "Swift"
        static let CLanguage = "C"
        static let JavaLanguage = "Java"
        static let PythonLanguage = "Python"
        static let PHPLanguage = "PHP"
        static let Language = "language:"
        static let Star = "star"
        static let AcsOrder = "asc"
        static let DecsOrder = "decs"
        
        static let LanguageArr = [SwiftLanguage,
                                   CLanguage,
                                   JavaLanguage,
                                   PythonLanguage,
                                   PHPLanguage]
    }
    
    struct GitAPIResponseKeys{
        
    }
}
