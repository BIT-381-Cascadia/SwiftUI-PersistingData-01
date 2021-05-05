// CREDIT: This code is mostly copied from https://docs.mongodb.com/realm-legacy/docs/swift/latest/index.html

import Foundation
import RealmSwift


// Define your models like regular Swift classes
class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    convenience init(name:String, age:Int) {
        self.init() // call designated init first
        self.name = name
        self.age = age
    }
}
class Cat: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    convenience init(name:String, age:Int) {
        self.init() // call designated init first
        self.name = name
        self.age = age
    }
}
class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var picture: Data? = nil // optionals supported
    let dogs = List<Dog>()
    convenience init(name: String, pic: Data? = nil) {
        self.init() // call designated init first
        self.name = name
        self.picture = pic
    }
}

func setDefaultRealmForUser(filename: String) {
    var config = Realm.Configuration()

    // Use the default directory, but replace the filename with the parameter
    config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(filename).realm")

    // Set this as the configuration used for the default Realm
    Realm.Configuration.defaultConfiguration = config
}

class TestRealm {
    
    func RunTest() {
        // Use them like regular Swift objects
        let myDog = Dog()
        myDog.name = "Rex"
        myDog.age = 1
        print("name of dog: \(myDog.name)")

        let myCat = Cat()
        myCat.name = "Jeff"
        myCat.age = 4
        
        var realm = try! Realm()
        try! realm.write {
            realm.add(myDog)
        }
        try! realm.write {
            realm.add(myDog)
        }
        try! realm.write {
            realm.add(myDog)
        }
        var puppies = realm.objects(Dog.self)
        print(puppies.count) // => 0 because no dogs have been added to the Realm yet
        
        setDefaultRealmForUser(filename: "catDB") // use this to change DBs, if you want
        // Get the default Realm
         realm = try! Realm()
        var kitties = realm.objects(Cat.self)
        // Query Realm for all dogs less than 2 years old
         puppies = realm.objects(Dog.self)
        print(puppies.count) // => 0 because no dogs have been added to the Realm yet

        if let pup = puppies.first {
            print(pup.name)
            print(pup.age)
        }
        
        // Persist your data easily
        try! realm.write {
            realm.add(myCat)
        }
        if let kitty = kitties.first {
            print(kitty.name)
            print(kitty.age)
        }

        // Queries are updated in realtime
        print("Puppies: \(puppies.count)") // => 1
        print("Kitties: \(kitties.count)")

        // OPTIONAL, ADVANCED STUFF I LEFT IN HERE WHEN I COPIED THIS CODE FROM https://docs.mongodb.com/realm-legacy/docs/swift/latest/index.html
        // Query and update from any thread
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let theDog = realm.objects(Dog.self).filter("age == 1").first
                try! realm.write {
                    theDog!.age = 3
                    print("written")
                }
            }
        }
    }
}

