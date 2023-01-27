//
//  FavoriteGameProvider.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 14/01/23.
//

import Foundation
import CoreData

class FavoriteGameProvider {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteGameModel")
        
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Persistent Container Error \(String(describing: error))")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    func getAllFavorites(completion: @escaping(_ games: [GameModel]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [GameModel] = []

                for result in results {
                    let game = GameModel(
                        id: Int(result.value(forKey: "id") as! Int32),
                        slug: result.value(forKey: "slug") as! String,
                        name: result.value(forKey: "name") as! String,
                        released: result.value(forKey: "released") as! String,
                        platforms: result.value(forKey: "platforms") as! String,
                        backgroundImage: result.value(forKey: "backgroundImage") as! String,
                        rating: result.value(forKey: "rating") as! Double,
                        isFavorite: true
                    )

                    games.append(game)
                }
                completion(games)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func getFavoriteBySlug(_ slug: String, completion: @escaping(_ game: GameModel) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "slug == '\(slug)'")
            do {
                if let result = try taskContext.fetch(fetchRequest).first{
                    let game = GameModel(
                        id: Int(result.value(forKey: "id") as! Int32),
                        slug: result.value(forKey: "slug") as! String,
                        name: result.value(forKey: "name") as! String,
                        released: result.value(forKey: "released") as! String,
                        platforms: result.value(forKey: "platforms") as! String,
                        backgroundImage: result.value(forKey: "backgroundImage") as! String,
                        rating: result.value(forKey: "rating") as! Double,
                        isFavorite: true
                    )
                    completion(game)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func addFavorite(_ game: GameModel, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: taskContext) {
                let member = NSManagedObject(entity: entity, insertInto: taskContext)
                self.getMaxId { id in
                    member.setValue(id+1, forKeyPath: "id")
                    member.setValue(game.slug, forKeyPath: "slug")
                    member.setValue(game.name, forKeyPath: "name")
                    member.setValue(game.released, forKeyPath: "released")
                    member.setValue(game.platforms, forKeyPath: "platforms")
                    member.setValue(game.backgroundImage, forKeyPath: "backgroundImage")
                    member.setValue(game.rating, forKeyPath: "rating")
                        
                    do {
                        try taskContext.save()
                        completion()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
            }
        }
    }
    
    func updateFavorite(
        _ id: Int,
        _ slug: String,
        _ name: String,
        _ released: String,
        _ platforms: String,
        _ backgroundImage: String,
        _ rating: Double,
        completion: @escaping() -> Void
    ) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            if let result = try? taskContext.fetch(fetchRequest), let member = result.first as? Favorite {
                member.setValue(id, forKeyPath: "id")
                member.setValue(slug, forKeyPath: "slug")
                member.setValue(name, forKeyPath: "name")
                member.setValue(released, forKeyPath: "released")
                member.setValue(platforms, forKeyPath: "platforms")
                member.setValue(backgroundImage, forKeyPath: "backgroundImage")
                member.setValue(rating, forKeyPath: "rating")
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func deleteAllFavorite(completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
    
    func deleteFavorite(_ slug: String, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "slug == '\(slug)'")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
    
    
    func getMaxId(completion: @escaping(_ maxId: Int) -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            fetchRequest.fetchLimit = 1
            do {
                let lastMember = try taskContext.fetch(fetchRequest)
                if let member = lastMember.first, let position = member.value(forKeyPath: "id") as? Int{
                    completion(position)
                } else {
                    completion(0)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
