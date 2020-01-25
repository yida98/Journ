//
//  YearMonthDict.swift
//  Journ
//
//  Created by Yida Zhang on 2020-01-18.
//  Copyright © 2020 Yida Zhang. All rights reserved.
//

import Foundation

struct YearMonthDict {
    private var y: Int
    private var m: Int
    
    init(y: Int, m: Int) {
        self.y = y
        self.m = m
    }
    
    func getY() -> Int {
        return y
    }
    
    func getM() -> Int {
        return m
    }
    
    func getNextMonth() -> YearMonthDict? {
        var rm = m
        var ry = y
        if self.y < Date().getYear() {
            if self.m == 12 {
                rm = 1
                ry += 1
            } else {
                rm += 1
            }
        } else {
            if self.m < Date().getMonth() {
                rm += 1
            } else {
                return nil
            }
        }
        return YearMonthDict(y: ry, m: rm)
    }
    
    func getPrevMonth() -> YearMonthDict? {
        var rm = m
        var ry = y
        if self.y < Date().getYear() {
            if self.m == 12 {
                rm = 1
                ry += 1
            } else {
                rm += 1
            }
        } else {
            if self.m < Date().getMonth() {
                rm += 1
            } else {
                return nil
            }
        }
        return YearMonthDict(y: ry, m: rm)
    }
}
