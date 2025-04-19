import SwiftUI
import Combine

final class ParametersStore: ObservableObject {
    @Published var params = PhysicsParameters()
}

final class PhysicsParameters: ObservableObject {
    @Published var gravity: Double = 9.8
    @Published var impulse: Double = 30
    @Published var ballMass: Double = 15
    @Published var ballRestitution: Double = 0.7
    @Published var ballFriction: Double = 0.3
    @Published var blockMass: Double = 2
    @Published var blockRestitution: Double = 0.2
    @Published var blockFriction: Double = 0.6
    @Published var slingHeight: Double = 120
    @Published var slingshotX: Double = 0.30
    @Published var stackX: Double = 0.80
}
