//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


class Person {
    
    // class function
    func speakName() {
        print("My name is Jack Davis")
    }
    
    // static function
    class func speakSomethingGeneral() {
        print("I am a human")
    }
    
}

let person = Person()
person.speakName()
Person.speakSomethingGeneral()












