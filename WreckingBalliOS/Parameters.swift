// Modified version with renamed variables
import SwiftUI
import Combine

final class ParametersStore: ObservableObject {
    @Published var zeta = PhysicsParameters()
}

final class PhysicsParameters: ObservableObject {
    @Published var etaTwo: Double = 9.8
    @Published var thetaTwo: Double = 30
    @Published var omega: Double = 15
    @Published var alphaTwo: Double = 0.7
    @Published var gammaTwo: Double = 0.3
    @Published var deltaTwo: Double = 2
    @Published var epsilonTwo: Double = 0.2
    @Published var zetaTwo: Double = 0.6
    @Published var kappa: Double = 120
    @Published var theta: Double = 0.30
    @Published var iota: Double = 0.80
}
