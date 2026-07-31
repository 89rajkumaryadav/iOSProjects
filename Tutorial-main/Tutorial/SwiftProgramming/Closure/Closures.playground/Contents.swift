import UIKit
//https://www.youtube.com/watch?v=JqBeH8Q7N5w&list=PLV7VzbWXa60EiWHqcH_pNjuVYxW0JpcET&index=14


// Simple closure

var message = {
    print("Hello iOS Developers.")
}

message()


// Closures with Prams
var sayGoodMorning = { (name:String) in
    print("Good morning \(name)")
}


// Closure with return type
var sumTwoNumbers = {(num1:Int, num2:Int) -> Int in
   return num1 + num2
}

var sum = sumTwoNumbers(5, 4)
print(sum)


// Closure as func arguments

func sayNoon(isNoon: Bool, greet:(String)->()){
    if isNoon{
        greet("It's Noom")
    }else{
        greet("It's not Noom")
    }
}

sayNoon(isNoon: true) { msg in
    print(msg)
}



// Capture list in closure

// senario 1
/*
var name = "Raj"

let closure = { [name]
    print("My name is \(name)")
}

name = "App Developer"
closure()
 */



//2
/*
var name = "Raj"

let closure = { [name] in
    print("My name is \(name)")
}

name = "App Developer"
closure()
*/


//3 Capture vs non capture value
var name = "Raj"
var technology = "iOS"
let closure = { [name] in
    print("My name is \(name)")
    print("I love \(technology).")
}

name = "App Developer"
technology = "Android"
closure()




// Example of referance type closure

func exicute() -> (Int) -> Int {
    var input = 0
    
    return { output in
        input = output + input
        return input
        
    }
}


let op = exicute()
let a = op(5)
let b = op(10)
let c = op(15)

print("Guess the answer: \(c)")

