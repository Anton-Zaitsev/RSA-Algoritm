//
//  main.swift
//  RSA
//
//  Created by Антон Зайцев on 29.11.2021.
//

import Foundation

func toPow (num: Int, power: Int) -> Int{
    var result = 1
    for _ in 0..<power {
        result *= num
    }
    return result
}

private func gcd(_ a: Int, _ b: Int) -> Int {
    let remainder = abs(a) % abs(b)
    if remainder != 0 {
        return gcd(abs(b), remainder)
    } else {
        return abs(b)
    }
}
private func coprime(_ a: Int, _ b: Int ) -> Bool {
    return  gcd(a,b) == 1
}

public func NumberPrime() -> (mass: [Int], numberOne: Int, numberTwo: Int) {
    let n = 10000
    var mass : [Int] = []
    for i in 0 ... n {
        mass.append(i)
    }
    mass[1] = 0
    var i : Int = 2
    var j : Int = 0
    
    while Int(pow(Double(i), 2)) <= n {
        if (mass[i] != 0) {
            j = i * 2
            while j <= n {
                mass[j] = 0
                j += i
            }
        }
        i += 1
    }
    var mySet = Set<Int>(mass)
    mySet.remove(0)
    print(mySet)
    var index = Int.random(in: 0..<mySet.count - 1)
    var newMass = Array(mySet)
    let numberOne = newMass[index]
    print("NumberOne = \(numberOne)")
    mySet.remove(numberOne)
    newMass = Array(mySet)
    index = Int.random(in: 0..<mySet.count - 1)
    let numberTwo = newMass[index]
    print("NumberTwo = \(numberTwo)")
    mySet.remove(numberTwo)
    newMass = Array(mySet)
    mySet = Set<Int>(newMass)
    print(mySet)
    return (Array(mySet),numberOne, numberTwo)
}

var (mass, numberOne, numberTwo) = NumberPrime()
print("P = \(numberOne)")
print("Q = \(numberTwo)")
let numberM = numberOne * numberTwo
print("M = \(numberM)")
let numberF = (numberOne - 1) * (numberTwo - 1)
print("F = \(numberF)")
var numberE = mass[Int.random(in: 0..<mass.count)]
print("E = \(numberE)")

var flag = true
while flag{
    if ((1 < numberE && numberE < numberF) || coprime(numberE,numberF)) {
        print("Change E!")
        print("Number E from flag = \(numberE)")
        if let index = mass.firstIndex(of: numberE) {
            mass.remove(at: index)
        }
        if (mass.count != 0) {
        let random = Int.random(in: 0..<mass.count)
        numberE = mass[random]
        }
        else {
            flag = false
        }
    }
    else {
        flag = false
    }
}
var numberD = 0
for i in 3..<numberF {
    let step = i + 2
    if ((step * numberE) % numberF == 1) {
        print("D = \(step)")
        numberD = step
        break
    }
}


let myNumber = 228
let cr = toPow(num: myNumber, power: numberD) % numberM
print("CR = \(cr)")
let decr = toPow(num: cr, power: numberD) % numberM
print("DEC = \(decr)")

if (myNumber == decr) {
    print("Succ")
}
else {
    print("Fail")
}




