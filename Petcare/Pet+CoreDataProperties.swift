//
//  Pet+CoreDataProperties.swift
//
//
//  Created by Raul Marques de Oliveira on 30/11/16.
//
//

import Foundation
import CoreData


extension Pet {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet");
    }
    
    @NSManaged public var birthdate: NSDate?
    @NSManaged public var breed: String?
    @NSManaged public var name: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var sex: String?
    @NSManaged public var type: String?
    @NSManaged public var bath: NSOrderedSet?
    @NSManaged public var deworming: NSOrderedSet?
    @NSManaged public var hair: NSOrderedSet?
    @NSManaged public var nails: NSOrderedSet?
    @NSManaged public var recreation: NSOrderedSet?
    @NSManaged public var teeth: NSOrderedSet?
    @NSManaged public var vaccination: NSOrderedSet?
    
}

// MARK: Generated accessors for bath
extension Pet {
    
    @objc(insertObject:inBathAtIndex:)
    @NSManaged public func insertIntoBath(_ value: Bath, at idx: Int)
    
    @objc(removeObjectFromBathAtIndex:)
    @NSManaged public func removeFromBath(at idx: Int)
    
    @objc(insertBath:atIndexes:)
    @NSManaged public func insertIntoBath(_ values: [Bath], at indexes: NSIndexSet)
    
    @objc(removeBathAtIndexes:)
    @NSManaged public func removeFromBath(at indexes: NSIndexSet)
    
    @objc(replaceObjectInBathAtIndex:withObject:)
    @NSManaged public func replaceBath(at idx: Int, with value: Bath)
    
    @objc(replaceBathAtIndexes:withBath:)
    @NSManaged public func replaceBath(at indexes: NSIndexSet, with values: [Bath])
    
    @objc(addBathObject:)
    @NSManaged public func addToBath(_ value: Bath)
    
    @objc(removeBathObject:)
    @NSManaged public func removeFromBath(_ value: Bath)
    
    @objc(addBath:)
    @NSManaged public func addToBath(_ values: NSOrderedSet)
    
    @objc(removeBath:)
    @NSManaged public func removeFromBath(_ values: NSOrderedSet)
    
}

// MARK: Generated accessors for deworming
extension Pet {
    
    @objc(insertObject:inDewormingAtIndex:)
    @NSManaged public func insertIntoDeworming(_ value: Deworming, at idx: Int)
    
    @objc(removeObjectFromDewormingAtIndex:)
    @NSManaged public func removeFromDeworming(at idx: Int)
    
    @objc(insertDeworming:atIndexes:)
    @NSManaged public func insertIntoDeworming(_ values: [Deworming], at indexes: NSIndexSet)
    
    @objc(removeDewormingAtIndexes:)
    @NSManaged public func removeFromDeworming(at indexes: NSIndexSet)
    
    @objc(replaceObjectInDewormingAtIndex:withObject:)
    @NSManaged public func replaceDeworming(at idx: Int, with value: Deworming)
    
    @objc(replaceDewormingAtIndexes:withDeworming:)
    @NSManaged public func replaceDeworming(at indexes: NSIndexSet, with values: [Deworming])
    
    @objc(addDewormingObject:)
    @NSManaged public func addToDeworming(_ value: Deworming)
    
    @objc(removeDewormingObject:)
    @NSManaged public func removeFromDeworming(_ value: Deworming)
    
    @objc(addDeworming:)
    @NSManaged public func addToDeworming(_ values: NSOrderedSet)
    
    @objc(removeDeworming:)
    @NSManaged public func removeFromDeworming(_ values: NSOrderedSet)
    
}

// MARK: Generated accessors for hair
extension Pet {
    
    @objc(insertObject:inHairAtIndex:)
    @NSManaged public func insertIntoHair(_ value: Hair, at idx: Int)
    
    @objc(removeObjectFromHairAtIndex:)
    @NSManaged public func removeFromHair(at idx: Int)
    
    @objc(insertHair:atIndexes:)
    @NSManaged public func insertIntoHair(_ values: [Hair], at indexes: NSIndexSet)
    
    @objc(removeHairAtIndexes:)
    @NSManaged public func removeFromHair(at indexes: NSIndexSet)
    
    @objc(replaceObjectInHairAtIndex:withObject:)
    @NSManaged public func replaceHair(at idx: Int, with value: Hair)
    
    @objc(replaceHairAtIndexes:withHair:)
    @NSManaged public func replaceHair(at indexes: NSIndexSet, with values: [Hair])
    
    @objc(addHairObject:)
    @NSManaged public func addToHair(_ value: Hair)
    
    @objc(removeHairObject:)
    @NSManaged public func removeFromHair(_ value: Hair)
    
    @objc(addHair:)
    @NSManaged public func addToHair(_ values: NSOrderedSet)
    
    @objc(removeHair:)
    @NSManaged public func removeFromHair(_ values: NSOrderedSet)
    
}

// MARK: Generated accessors for nails
extension Pet {
    
    @objc(insertObject:inNailsAtIndex:)
    @NSManaged public func insertIntoNails(_ value: Nails, at idx: Int)
    
    @objc(removeObjectFromNailsAtIndex:)
    @NSManaged public func removeFromNails(at idx: Int)
    
    @objc(insertNails:atIndexes:)
    @NSManaged public func insertIntoNails(_ values: [Nails], at indexes: NSIndexSet)
    
    @objc(removeNailsAtIndexes:)
    @NSManaged public func removeFromNails(at indexes: NSIndexSet)
    
    @objc(replaceObjectInNailsAtIndex:withObject:)
    @NSManaged public func replaceNails(at idx: Int, with value: Nails)
    
    @objc(replaceNailsAtIndexes:withNails:)
    @NSManaged public func replaceNails(at indexes: NSIndexSet, with values: [Nails])
    
    @objc(addNailsObject:)
    @NSManaged public func addToNails(_ value: Nails)
    
    @objc(removeNailsObject:)
    @NSManaged public func removeFromNails(_ value: Nails)
    
    @objc(addNails:)
    @NSManaged public func addToNails(_ values: NSOrderedSet)
    
    @objc(removeNails:)
    @NSManaged public func removeFromNails(_ values: NSOrderedSet)
    
}

// MARK: Generated accessors for recreation
extension Pet {
    
    @objc(insertObject:inRecreationAtIndex:)
    @NSManaged public func insertIntoRecreation(_ value: Recreation, at idx: Int)
    
    @objc(removeObjectFromRecreationAtIndex:)
    @NSManaged public func removeFromRecreation(at idx: Int)
    
    @objc(insertRecreation:atIndexes:)
    @NSManaged public func insertIntoRecreation(_ values: [Recreation], at indexes: NSIndexSet)
    
    @objc(removeRecreationAtIndexes:)
    @NSManaged public func removeFromRecreation(at indexes: NSIndexSet)
    
    @objc(replaceObjectInRecreationAtIndex:withObject:)
    @NSManaged public func replaceRecreation(at idx: Int, with value: Recreation)
    
    @objc(replaceRecreationAtIndexes:withRecreation:)
    @NSManaged public func replaceRecreation(at indexes: NSIndexSet, with values: [Recreation])
    
    @objc(addRecreationObject:)
    @NSManaged public func addToRecreation(_ value: Recreation)
    
    @objc(removeRecreationObject:)
    @NSManaged public func removeFromRecreation(_ value: Recreation)
    
    @objc(addRecreation:)
    @NSManaged public func addToRecreation(_ values: NSOrderedSet)
    
    @objc(removeRecreation:)
    @NSManaged public func removeFromRecreation(_ values: NSOrderedSet)
    
}

// MARK: Generated accessors for teeth
extension Pet {
    
    @objc(insertObject:inTeethAtIndex:)
    @NSManaged public func insertIntoTeeth(_ value: Teeth, at idx: Int)
    
    @objc(removeObjectFromTeethAtIndex:)
    @NSManaged public func removeFromTeeth(at idx: Int)
    
    @objc(insertTeeth:atIndexes:)
    @NSManaged public func insertIntoTeeth(_ values: [Teeth], at indexes: NSIndexSet)
    
    @objc(removeTeethAtIndexes:)
    @NSManaged public func removeFromTeeth(at indexes: NSIndexSet)
    
    @objc(replaceObjectInTeethAtIndex:withObject:)
    @NSManaged public func replaceTeeth(at idx: Int, with value: Teeth)
    
    @objc(replaceTeethAtIndexes:withTeeth:)
    @NSManaged public func replaceTeeth(at indexes: NSIndexSet, with values: [Teeth])
    
    @objc(addTeethObject:)
    @NSManaged public func addToTeeth(_ value: Teeth)
    
    @objc(removeTeethObject:)
    @NSManaged public func removeFromTeeth(_ value: Teeth)
    
    @objc(addTeeth:)
    @NSManaged public func addToTeeth(_ values: NSOrderedSet)
    
    @objc(removeTeeth:)
    @NSManaged public func removeFromTeeth(_ values: NSOrderedSet)
    
}

// MARK: Generated accessors for vaccination
extension Pet {
    
    @objc(insertObject:inVaccinationAtIndex:)
    @NSManaged public func insertIntoVaccination(_ value: Vaccination, at idx: Int)
    
    @objc(removeObjectFromVaccinationAtIndex:)
    @NSManaged public func removeFromVaccination(at idx: Int)
    
    @objc(insertVaccination:atIndexes:)
    @NSManaged public func insertIntoVaccination(_ values: [Vaccination], at indexes: NSIndexSet)
    
    @objc(removeVaccinationAtIndexes:)
    @NSManaged public func removeFromVaccination(at indexes: NSIndexSet)
    
    @objc(replaceObjectInVaccinationAtIndex:withObject:)
    @NSManaged public func replaceVaccination(at idx: Int, with value: Vaccination)
    
    @objc(replaceVaccinationAtIndexes:withVaccination:)
    @NSManaged public func replaceVaccination(at indexes: NSIndexSet, with values: [Vaccination])
    
    @objc(addVaccinationObject:)
    @NSManaged public func addToVaccination(_ value: Vaccination)
    
    @objc(removeVaccinationObject:)
    @NSManaged public func removeFromVaccination(_ value: Vaccination)
    
    @objc(addVaccination:)
    @NSManaged public func addToVaccination(_ values: NSOrderedSet)
    
    @objc(removeVaccination:)
    @NSManaged public func removeFromVaccination(_ values: NSOrderedSet)
    
}
