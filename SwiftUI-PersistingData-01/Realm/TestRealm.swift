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
class Vehicle: Object {
    @objc dynamic var type = ""
    @objc dynamic var year = 0
    convenience init(name:String, age:Int) {
        self.init()
        self.type = type
        self.year = year
    }
}

func setDefaultRealmForUser(filename: String) {
    var config = Realm.Configuration()

    // Use the default directory, but replace the filename with the parameter
    config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(filename).realm")

    // Set this as the configuration used for the default Realm
    Realm.Configuration.defaultConfiguration = config
}

class CarRealm {


    
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
        print()
        let newCar = Vehicle()
        newCar.type = "Mazda"
        newCar.year = 2015
        
        let newCar2 = Vehicle()
        newCar2.type = "Ford"
        newCar2.year = 2052
        
        let CarRealm = try! Realm()
        
        try! CarRealm.write {
            CarRealm.add(newCar)
            CarRealm.add(newCar2)
        }
        
        let cars = CarRealm.objects(Vehicle.self)
        
        if let car = cars.first{
            print(car.type)
            print()
        }
        
        let FutureCar = CarRealm.objects(Vehicle.self).filter("year > 2021")
        
        if let fC = FutureCar.first{
            print(fC.type)
            print(fC.year)
        }
        
        
        
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

