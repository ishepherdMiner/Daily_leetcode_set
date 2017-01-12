//
//  TwoSum.swift
//  Daily_leetcode_set
//
//  Created by Jason on 12/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

import UIKit

class TwoSum: NSObject {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for i in 0..<nums.count {
            for j in 1..<nums.count {
                if j < i {continue}
                if nums[i] + nums[j] == target {
                    return [i,j]
                }
            }
        }
        return [0,0]
    }
}
