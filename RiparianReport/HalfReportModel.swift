//
//  HalfReportModel.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/16/23.
//

import Foundation

class HalfReportModel: Encodable, Decodable {
    var type:String = ""
    var question:String = ""
    var choices:String = ""
}


extension Encodable {
    var toDictionary: [String: Any]?{
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
