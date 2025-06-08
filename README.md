
https://github.com/user-attachments/assets/f5b06a8d-2b4b-47fd-a9c9-e99424fe18ee

# WreckingBalliOS

A small iOS app demonstrating:
- SwiftUI integration with SpriteKit
- A simple ECS (Entity-Component-System)
- Real-time physics tuning via Combine

## 📦 Structure
- **App**: `WreckingBalliOSApp.swift` (entry point)
- **Parameters**: `Parameters.swift` (stores physics settings)
- **Core**:  
  - `GameScene.swift` (scene setup + touch handling)  
  - `GameController.swift` (entity creation + game logic)  
- **ECS**:  
  - `ECS.swift` (Entity, Component, World)  
  - `Systems.swift` (`InputSystem`, `RenderSystem`)  
- **Utils**:  
  - `Coordinate.swift`, `Extensions.swift`

## 🚀 Getting Started
```bash
git clone (https://github.com/Adco30/WreckingBall/)
open WreckingBalliOS.xcodeproj
⌘R
```

🎮 How to Play
- Pull the on-screen ball back with your finger.
- Release to fling and knock down blocks.
- weak sliders (mass, friction, gravity…) in the side panel to see effects live.
