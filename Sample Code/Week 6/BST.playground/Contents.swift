//: Playground - noun: a place where people can play

import UIKit

class BinarySearchTree {
  
  var root : Node?
  
  func addData(data : AnyObject, forKey : Int) -> Bool {
    if root == nil {
     self.root = Node(key: forKey, data: data)
      return true
    }
    
    var currentNode = root
    var parentNode : Node?
    
    while currentNode != nil {
      if forKey == currentNode?.key {
        return false
      }
      parentNode = currentNode!
      if currentNode?.key > forKey {
        currentNode = currentNode?.left
      } else {
        currentNode = currentNode?.right
      }
    }
    
    if parentNode?.key > forKey {
      parentNode!.left = Node(key: forKey, data: data)
    } else {
      parentNode!.right = Node(key: forKey, data: data)
    }
    return true
  }
  
}

class Node {
  var key : Int
  var data : AnyObject
  var right : Node?
  var left : Node?
  
  init(key : Int, data : AnyObject) {
    self.key = key
    self.data = data
  }
}


var bst = BinarySearchTree()

bst.addData("Hi", forKey: 4)
bst.addData("goodbye", forKey: 31)
bst.addData("seahawks", forKey: 45)

println(bst)