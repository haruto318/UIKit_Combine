//
//  Model.swift
//  UIKit_Combine
//
//  Created by 濱野遥斗 on 2024/06/09.
//

import Foundation

final class Model {
    @Published private(set) var value: String = ""
    
    func setValue(value: String){
        self.value = value
    }
}
