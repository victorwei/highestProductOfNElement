//: Playground - noun: a place where people can play

import UIKit

/*********************************************************************
 
 Coding Challenge: Given an array of Ints and variable n, find the highest product of n elements within the array
 Target time complexity: O(n)
 
 Test case 1: [2, -3, 4, 8, -7, 3 ] , n = 3
 result = 168   // -3, 8, -7
 
 Test case 2: [-3, 8, -20, 10] , n = 2
 result = 80    // 8, 10

 *********************************************************************/


func getHighestProduct (arr: [Int], window: Int) -> Int {
    
    //test for valid inputs
    if arr.count == 0 || arr.count < window || window < 1{
        return 0
    }
    
    //Logic: Create an array to keep track of the greatest and lowest values up to that point.  For example, if we are trying to find the highest 4 products, we want to find the max product of 3, max product of 2, and max value.  Conversely, we want to get the lowest values as well to account for negative numbers
    
    //Initialize the array with the first value
    var maxArr: [Int] = [arr[0]]
    var minArr: [Int] = [arr[0]]
    
    //For the given window size, loop through the array up to the window size
    for index in 1..<window {
        
        let current = arr[index]
        
        //get the new product of the current value * max/low product of previous value
        maxArr.append(max(current * maxArr[index - 1], current * minArr[index - 1]))
        minArr.append(min(current * maxArr[index - 1], current * minArr[index - 1]))
        
        //Go through previous max/min products to update
        for num in (0..<index).reversed() {
            
            //check if the new value is the max or min value
            if num == 0 {
                maxArr[num] = max(current, maxArr[num])
                minArr[num] = min(current, minArr[num])
                
                //check if the new product is a max or min product
            } else {
                maxArr[num] = max(maxArr[num], current * maxArr[num - 1], current * minArr[num - 1])
                minArr[num] = min(minArr[num], current * maxArr[num - 1], current * minArr[num - 1])
            }
        }
    }
    
    
    //loop through the rest of the array
    for index in window..<arr.count {
        
        let current = arr[index]
        
        //loop through the max/min arrays to determine if we have new max/min products
        for num in (0..<window).reversed(){
            if num == 0 {
                maxArr[num] = max(current, maxArr[num])
                minArr[num] = min(current, minArr[num])
            } else {
                maxArr[num] = max(maxArr[num], current * maxArr[num - 1], current * minArr[num - 1])
                minArr[num] = min(minArr[num], current * maxArr[num - 1], current * minArr[num - 1])
            }
        }
    }
    
    
    //return the value for the maximum product of window size
    return maxArr[window - 1]
}






//Test Cases



var arrExample = [2, -5, 5, 8, -9, 3, 16]
var testArr = [-3, -20, 8, 10]

getHighestProduct(arr: arrExample, window: 3)
