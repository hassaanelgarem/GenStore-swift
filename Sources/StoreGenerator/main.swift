import StoreGeneratorCore

let tool = StoreGenerator()

do {
    try tool.run()
}
catch let error as StoreGenerator.Error {
    print("Whoops! An error occurred: \(error.localizedDescription)")
}

catch {
    print("Whoops! An error occurred: \(error)")
}
