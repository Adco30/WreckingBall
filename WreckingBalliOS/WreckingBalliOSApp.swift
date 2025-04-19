import SwiftUI

@main
struct WreckingBalliOSApp: App {
    @StateObject private var store = ParametersStore()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
