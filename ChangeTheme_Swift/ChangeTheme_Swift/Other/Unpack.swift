//
//  Unpack.swift
//  ChangeTheme_Swift
//
//  Created by weijingyun on 2017/9/4.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

import Foundation

public struct NilError: Error, CustomStringConvertible {
    public var description: String { return _description }
    public init(tip : String,file: String, line: Int) {
        _description = "Nil returned at " + tip + " "
            + (file as NSString).lastPathComponent + ":\(line)"
    }
    private let _description: String
}

extension Optional {
    public func unwrap(tip : String = "", file: String = #file, line: Int = #line) throws -> Wrapped {
        guard let unwrapped = self else { throw NilError(tip:tip, file: file, line: line) }
        return unwrapped
    }
}
