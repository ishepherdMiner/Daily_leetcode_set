//
//  ViewController.swift
//  Daily_leetcode_set
//
//  Created by Jason on 12/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let s = AlgorithmsSolution()
//
//        print(s.twoSum([3,5,9,12], 15))
//        
//        let l1 = ListNode(2)
//        l1.next = ListNode(4)
//        l1.next?.next = ListNode(3)
//        
//        let l2 = ListNode(5)
//        l2.next = ListNode(6)
//        l2.next?.next = ListNode(4)
//        
//        print(s.addTwoNumbers(l1, l2)!)
        
        // print(s.lengthOfLongestSubstring("abcabcbb")) // 3
        // print(s.lengthOfLongestSubstring("pwwkew"))   // 3
        print(s.lengthOfLongestSubstring("aab"))      // 2
        print(s.lengthOfLongestSubstring("dvdf"))     // 3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

