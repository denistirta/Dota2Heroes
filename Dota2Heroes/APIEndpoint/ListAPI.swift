//
//  ListAPI.swift
//  Dota2Heroes
//
//  Created by DenisTirta on 12/08/21.
//

import Foundation

class HerosEndPoint{
    private static var base      = "/api"
    private static var _list     = "/herostats"
    
    static func list() -> String{
        return "\(BaseURL)\(base)/\(_list)"
    }
    
}
