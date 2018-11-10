//
//  enum.swift
//  learn-ios
//
//  Created by lvshutao on 2018/11/6.
//  Copyright © 2018 lvshutao. All rights reserved.
//

import Foundation


enum Direction {
    case Left
    case Right
    case Top
    
    func toString() -> String {
        switch self {
        case .Left:
            return "左"
        case .Right:
            return "右"
        case .Top:
            return "上"
        }
    }
}

//print("enum \(Direction.Left)")
//print("enum \(Direction.Left.toString())")

