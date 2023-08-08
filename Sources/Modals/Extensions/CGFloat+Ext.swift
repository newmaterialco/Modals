//
//  CGFloat+Ext.swift
//  FieldDay
//
//  Created by Samuel McGarry on 1/19/23.
//

import Foundation

extension CGFloat {
    func quarticEaseOut() -> CGFloat {
        let f = self - 1
        return f * f * f * (1 - self) + 1
    }
    
    func quarticEaseIn() -> CGFloat {
        return self * self * self * self
    }
}
