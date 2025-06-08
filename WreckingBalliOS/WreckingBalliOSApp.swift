// Modified version with renamed variables
import SwiftUI

@main
struct WreckingBalliOSApp: App {
    @StateObject private var alpha = ParametersStore()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(alpha)
        }
    }
}
