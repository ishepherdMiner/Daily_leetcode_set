//
//  AlgorithmsSolution.swift
//  Daily_leetcode_set
//
//  Created by Jason on 13/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

import UIKit

class AlgorithmsSolution: NSObject {
    /*
     * Status: Accepted
     *
     ********************************************************
     * Given an array of integers, return indices of the two numbers such that they add up to a specific target.
     
     You may assume that each input would have exactly one solution.
     
     Example:
     Given nums = [2, 7, 11, 15], target = 9,
     
     Because nums[0] + nums[1] = 2 + 7 = 9,
     return [0, 1].
     UPDATE (2016/2/13):
     The return format had been changed to zero-based indices. Please read the above updated description carefully.
     
     Subscribe to see which companies asked this question
     */
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
    
    /*
     * Status: Accepted
     *
     ********************************************************
     * You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.
     
     You may assume the two numbers do not contain any leading zero, except the number 0 itself.
     
     Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
     Output: 7 -> 0 -> 8
     */
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var carry = 0 // 进位
        var sum : ListNode?
        var iter = l1
        var follow = l2
        while (iter != nil) || (follow != nil) {
            let node = ListNode(0)
            
            if let _ = sum {
                var last = sum
                // find last node
                while (last?.next != nil) {
                    last = last?.next
                }
                last?.next = node
            }else {
                sum = node
            }
            // maybe two list length is different
            var val = ((iter != nil) ? iter! : ListNode(0)).val + ((follow != nil) ? follow! : ListNode(0)).val + carry
            
            if carry == 1 {
                carry = 0
            }
            
            if val >= 10 {
                val -= 10
                carry = 1
            }
            node.val = val
            iter = iter?.next
            follow = follow?.next
        }
        
        if carry == 1 {
            var last = sum
            // find last node
            while (last?.next != nil) {
                last = last?.next
            }
            last?.next = ListNode(1)
        }
        return sum;
    }
    
    /*
     * Status: Time Limit Exceeded
     *
     * Swift 试了好多种,都超时
     * http://xfhnever.com/2014/10/30/algorithm-lnrs/ 
     * http://www.geeksforgeeks.org/length-of-the-longest-substring-without-repeating-characters/
     * http://blog.csdn.net/suool/article/details/38360653
     * 
     * 有用Java写的,有python的,有C++的
     *
     * 题目讨论中的C++方法写的,能通过
     * 
     * vector<int> dict(256, -1);
     * int maxLen = 0, start = -1;
     * for (int i = 0; i != s.length(); i++) {
     *    if (dict[s[i]] > start)
     *    start = dict[s[i]];
     *    dict[s[i]] = i;
     *    maxLen = max(maxLen, i - start);
     * }
     * return maxLen;
     * 移植成Swift还是超时,我只能暂时认为是Swift本身的执行效率原因吧
     *
     ********************************************************
     * Given a string, find the length of the longest substring without repeating characters.
     * Examples:
     * Given "abcabcbb", the answer is "abc", which the length is 3.
     * Given "bbbbb", the answer is "b", with the length of 1.
     * Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
     */
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var visited = [Int:Int]()
        for i in 0..<256 {
            visited[i] = -1
        }
        var maxLen = 0
        var start = -1
        
        for i in 0..<s.lengthOfBytes(using: String.Encoding.utf8) {
            let cur = Int((String(s[s.index(s.startIndex, offsetBy: i)]).unicodeScalars.first?.value)!)
            if visited[cur]! > start {
                start = visited[cur]!
            }
            visited[cur]! = i
            maxLen = maxLen > i - start ? maxLen : i - start
        }
        return maxLen
    }
}

/*
 if s.isEmpty {
 return 0
 }
 
 if s.lengthOfBytes(using: String.Encoding.utf8) == 1 {
 return 1
 }
 var maxLen = 0
 var lastIndex = 0
 var current = 1
 var map = [String:Int]()
 map[s.substring(to:s.index(s.startIndex, offsetBy: 1))] = 0
 
 for i in 1..<s.lengthOfBytes(using: String.Encoding.utf8) {
 let curString = String(s[s.index(s.startIndex, offsetBy: i)])
 if map[curString] == nil {
 map[curString] = i
 current += 1
 }else {
 if lastIndex <= map[curString]! {
 current = i - map[curString]!
 lastIndex = map[curString]! + 1
 map.removeValue(forKey: curString)
 map[curString] = i
 }else {
 current += 1
 map.removeValue(forKey: curString)
 map[curString] = i
 }
 }
 
 if current > maxLen {
 maxLen = current
 }
 }
 return maxLen
 */

/*
 var cur = ""
 var count = cur.lengthOfBytes(using: String.Encoding.utf8)
 var rs = [String]()
 var step = s.startIndex
 var sub = s
 while true {
 var sign = true
 var notfindRepeatTimes = 0
 sub.characters.forEach({ (c) in
 // appear repeat character
 if let i = (cur.characters.index(of: c)) {
 if sign {
 // - 下一次的匹配位置是关键
 
 step = s.index(step, offsetBy: cur.distance(from: cur.startIndex, to: i)+1 - notfindRepeatTimes, limitedBy: s.endIndex)!
 rs.append(cur)
 cur.removeAll()
 sign = false
 }
 }else {
 if sign {
 cur.append(c)
 notfindRepeatTimes += 1
 step = s.index(step, offsetBy: 1, limitedBy:s.endIndex)!
 }
 }
 })
 
 sub = s.substring(from: step)
 if sub.lengthOfBytes(using: String.Encoding.utf8) == 0 {
 if cur.lengthOfBytes(using: String.Encoding.utf8) > 0 {
 rs.append(cur)
 }
 break
 }
 }
 
 rs.forEach { (s) in
 let sLength = s.lengthOfBytes(using: String.Encoding.utf8)
 if sLength > count {
 count = sLength
 }
 }
 
 return count

 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
