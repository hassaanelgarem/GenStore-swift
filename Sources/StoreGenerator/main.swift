import StoreGeneratorCore

let tool = StoreGenerator()

do {
    try tool.run()
}
catch let error as StoreGenerator.Error {
    print("An error occurred!\n\(error.localizedDescription)")
}

catch {
    print("An error occurred: \(error)")
}
