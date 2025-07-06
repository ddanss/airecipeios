import SwiftData
import Foundation

enum SchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Ingredient.self, Recipe.self]
    }
    
    // old model without createdDate
    @Model
    class Recipe {
        var title: String
        var ingredients: [[String:String]]
        var instructions: String
        
        init(title: String, ingredients: [[String:String]], instructions: String) {
            self.title = title
            self.ingredients = ingredients
            self.instructions = instructions
        }
    }
}

enum SchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 1)
    static var models: [any PersistentModel.Type] {
        [Ingredient.self, Recipe.self]
    }
}

struct RecipeMigrationPlan: SchemaMigrationPlan {
    static var schemas: [VersionedSchema.Type] {
        [SchemaV1.self, SchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        [v1ToV2]
    }
    
    static let v1ToV2 = MigrationStage.lightweight(fromVersion: SchemaV1.self, toVersion: SchemaV2.self)
}
