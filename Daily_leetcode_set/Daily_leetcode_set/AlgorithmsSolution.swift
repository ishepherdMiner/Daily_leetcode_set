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
     * Swift 试了好多种,改成Swift后都超时
     * http://xfhnever.com/2014/10/30/algorithm-lnrs/ 
     * http://www.geeksforgeeks.org/length-of-the-longest-substring-without-repeating-characters/
     * http://blog.csdn.net/suool/article/details/38360653
     * 
     * 有用Java写的,有python的,有C++的
     *
     * 题目讨论中的C++方法写的,能通过
     * abcabcbb
     * vector<int> dict(256, -1);
     * int maxLen = 0, start = -1;
     * for (int i = 0; i != s.length(); i++) {
     *    // 遇到重复字符
     *    if (dict[s[i]] > start)
     *       start = dict[s[i]];
     *    dict[s[i]] = i;
     *    maxLen = max(maxLen, i - start);
     * }
     * return maxLen;
     * 移植成Swift还是超时,我暂时认为是Swift本身的执行效率原因吧
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
    
    /*
     * Status:
     *
     ********************************************************
     There are two sorted arrays nums1 and nums2 of size m and n respectively.
     
     Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).
     
     Example 1:
     nums1 = [1, 3]
     nums2 = [2]
     
     The median is 2.0
     
     Example 2:
     nums1 = [1, 2]
     nums2 = [3, 4]
     
     The median is (2 + 3)/2 = 2.5
     */
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var nums3 = [Int]()
        var i = 0
        var j = 0        
        let isEven = (nums1.count + nums2.count) % 2 == 0
        while true {
            if nums1[i] > nums2[j] {
                nums3.append(nums2[j])
                j += 1
            }else {
                nums3.append(nums1[i])
                i += 1
            }
            if isEven {
                // Has error
                if nums3.count == (n1 + n2) >> 1 {
                    if nums1[i] > nums2[j] {
                        nums3.append(nums2[j])
                        j += 1
                    }else {
                        nums3.append(nums1[i])
                        i += 1
                    }
                    let n3 = nums3.count
                    print(Double(nums3[n3 - 1] + nums3[n3 - 2]) * 0.5)
                    return Double(nums3[n3 - 1] + nums3[n3 - 2]) * 0.5
                }
                
            }else {
                if nums3.count == ((n1 + n2) >> 1) + 1 {
                    print(Double(nums3.last!))
                    return Double(nums3.last!)
                }
            }
        }
    }
}

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
