# Nexus-Appendage
Nexus Appendage is a simple utiltiy based on Roblox's `IKControl`
to manage character parts (typically R15 arms and legs) with preset
contraints and additional functionality.

## Usage
When using R15 characters, a helper function will most likely be
used instead of the constructor.

```lua
local Appendage = require(game:GetService("ReplicatedStorage"):WaitForChild("NexusAppendage"):WaitForChild("Appendage"))
local Character = game:GetService("Players").LocalPlayer.Character

--Parameter 1: Preset of the appendage. "LeftArm", "RightArm", "LeftLeg", and "RightLeg" are included presets.
--Parameter 2: Character to reference.
--Parameter 3: Optional bool value that sets if the limb can be disconnected to meet the target. While unnatural, this may be desired in certain cases. Defaults to false (disconnection not allowed).
--Parameter 4: Optional smoothing time for the IKControl. 0 is default.
local LeftArm = Appendage.FromPreset("LeftArm", Character, true, 0.1)
```

With an appendage, the following methods are available:
- `Enable: (self: Appendage) -> ()`: Enables the underlying `IKControl`.
- `Disable: (self: Appendage) -> ()`: Disables the underlying `IKControl`.
- `SetSmoothTime: (self: Appendage, SmoothTime: number)`: Sets the smoothing time of the underlying `IKControl`.
- `MoveTo: (self: Appendage, Target: CFrame, TweenInfoObject: TweenInfo?) -> ()`: Sets the target of the appendage to the be the given CFrame relative to the starting attachment CFrame.
- `MoveToWorld: (self: Appendage, Target: CFrame, TweenInfoObject: TweenInfo?) -> ()`: Sets the target of the appendage to be the given CFrame in the world.
- `Destroy: (self: Appendage) -> ()`: Destroys the underlying `IKControl` and constraints.

## Contributing
Both issues and pull requests are accepted for this project.

## License
Nexus Appendage is available under the terms of the MIT License. See
[LICENSE](LICENSE) for details.