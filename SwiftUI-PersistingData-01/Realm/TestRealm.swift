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

/**
 1a-Create a new class Cat
 */
class Cat: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var sex = ""
    convenience init(name: String, age: Int, sex: String) {
        self.init()
        self.name = name
        self.age = age
        self.sex = sex
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

        // setDefaultRealmForUser(filename: "name_of_another_DB_file") // use this to change DBs, if you want
        // Get the default Realm
        let realm = try! Realm()

        // Query Realm for all dogs less than 2 years old
        let puppies = realm.objects(Dog.self).filter("age < 2")
        print(puppies.count) // => 0 because no dogs have been added to the Realm yet

        if let pup = puppies.first {
            print(pup.name)
            print(pup.age)
        }
        
        // Persist your data easily
        try! realm.write {
            realm.add(myDog)
        }

        // Queries are updated in realtime
        print(puppies.count) // => 1

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
        
        //1b-New object of type Cat
        let kitty = Cat()
        kitty.name = "Clara"
        kitty.age = 4
        kitty.sex = "female"
        print("name of Cat: \(kitty.name)")
        
        //1c-create a new database file for the Cat object
        setDefaultRealmForUser(filename: "Cats")
        
        //1d-write the new Cat object to the database
        try! realm.write{
            realm.add(kitty)
        }
        
        //1e-Create a new object kittyCat and save it into the database
        let kittyCat = Cat()
        kittyCat.name = "Jack"
        kittyCat.age = 3
        kittyCat.sex = "male"
        print("name of Cat: \(kittyCat.name)")
        
        try! realm.write{
            realm.add(kittyCat)
        }
        
        //1f-Get female cat out of the database
        let femaleCat = realm.objects(Cat.self).filter("sex = 'female'")
        print(femaleCat.count)
        
        
        //1g-get.first method to get the result of filtering!
        if let ct = femaleCat.first {
            print(ct.name)
            print(ct.age)
            print(ct.sex)
        }
        
    }
}

