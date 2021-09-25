import HGStringStoreGeneratorCore

let tool = HGStringStoreGenerator()

do {
    try tool.run()
}
catch let error as HGStringStoreGenerator.Error {
    print("Whoops! An error occurred: \(error.localizedDescription)")
}

catch {
    print("Whoops! An error occurred: \(error)")
}
