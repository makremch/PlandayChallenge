//
//  Utils.swift
//  Challenge
//
//  Created by Makrem Hammani on 18/7/2021.
//

import Foundation


class Utils {
    init(){} 
    func formatDate(date : Date , format : String) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        return dateFormatterPrint.string(from: date)
    }
}
