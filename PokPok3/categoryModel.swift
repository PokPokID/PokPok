////
////  categoryModel.swift
////  PokPok3
////
////  Created by Michelle Aurelia on 23/10/21.
////
//
//import Foundation
//import UIKit
//import CoreData
//
//class CategoryModel {
//  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//  var categories  = [Category]()
//
//  func insertCategory(category_name: String, category_month: String, category_budget: Int) -> ModelResponseDefault {
//    var response: ModelResponseDefault
//    let newItem = Category(context: context)
//    newItem.category_name = category_name
//    newItem.category_month = category_month
//    newItem.category_budget = 0
//
//    do{
//      try context.save()
//      response = ModelResponseDefault(query_status: true, message: "OK", data: nil)
//    } catch {
//      response = ModelResponseDefault(query_status: false, message: "Error: \(error)", data: nil)
//    }
//
//    return response
//  }
//
//  func updateCategoryBudget(param: String, amount: Int32){
//    let request : NSFetchRequest<Category> = Category.fetchRequest()
////    request.predicate = NSPredicate(format: "detail == %@", param)
//
//    do{
//      let data = try context.fetch(request)
//      if data.count == 1 {
//        let objectUpdate = data[0] as NSManagedObject
//        objectUpdate.setValue(amount, forKey: "category_budget")
//        try context.save()
//          }
//    } catch {
//      print(error)
//    }
//  }
//
//
//
//  func getCategoryByType(type: String, limit: Int=0) -> ModelResponseDefault {
//    var response : ModelResponseDefault
//    var categories: [Category]
//
//    let request : NSFetchRequest<Category> = Category.fetchRequest()
//  //  request.predicate = NSPredicate(format: "type == %@", type)
//  //  request.sortDescriptors = [NSSortDescriptor(key:"order", ascending:true)]
//    if(limit > 0 ){
//      request.fetchLimit = limit
//    }
//
//    do{
//      categories = try context.fetch(request)
//      response = ModelResponseDefault(query_status: true, message: "OK", data: categories)
//    } catch {
//      response = ModelResponseDefault(query_status: false, message: "Error: \(error)", data: [Category]())
//    }
//
//    return response
//  }
//
//  func countAllCategories() -> ModelResponseDefault {
//    var response : ModelResponseDefault
//    var categories: [Category]
//    let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//    do{
//      categories = try context.fetch(request)
//      response = ModelResponseDefault(query_status: true, message: "OK", data: categories.count)
//    } catch {
//      response = ModelResponseDefault(query_status: false, message: "Error: \(error)", data: 0)
//    }
//
//    return response
//  }
//
//  func initDefaultCategories(){
//    let categories_default = [
//      ["category_name":"Bills","category_month":"idk"]
////      ["category_name":"Entertainment"],
////      ["category_name":"Fashion"],
////      ["category_name":"Food"],
////      ["category_name":"Groceries"],
////      ["category_name":"Transportation"],
////      ["category_name":"Others"]
//    ]
//    var i:Int = 0
//    categories_default.forEach { category in
//      i+=1
//      let insert = CategoryModel().insertCategory(category_name: category["category_name"]!, category_month: category["category_month"]!, category_budget: i)
//      if(insert.query_status==true){
//        print("New catgory inserted")
//      }
//    }
//    print("Init categories succeess!")
//  }
//
//  func truncateAllData(){
//    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Category")
//    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//    do {
//      try context.execute(deleteRequest)
//    } catch let error as NSError {
//        print(error)
//    }
//  }
//}
