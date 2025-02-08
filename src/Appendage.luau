--Manages an appendage for a character, such as an arm or a leg.
--!strict

local TweenService = game:GetService("TweenService")

local Limb = require(script.Parent:WaitForChild("Limb"))

local Appendage = {}
Appendage.Presets = {
    LeftArm = {
        "UpperTorso",
        "LeftUpperArm",
        "LeftLowerArm",
        "LeftHand",
        "LeftShoulder",
        "LeftShoulderRigAttachment",
        "LeftElbowRigAttachment",
        "LeftWristRigAttachment",
        "LeftGripAttachment",
    },
    RightArm = {
        "UpperTorso",
        "RightUpperArm",
        "RightLowerArm",
        "RightHand",
        "RightShoulder",
        "RightShoulderRigAttachment",
        "RightElbowRigAttachment",
        "RightWristRigAttachment",
        "RightGripAttachment",
    },
    LeftLeg = {
        "LowerTorso",
        "LeftUpperLeg",
        "LeftLowerLeg",
        "LeftFoot",
        "LeftHip",
        "LeftHipRigAttachment",
        "LeftKneeRigAttachment",
        "LeftAnkleRigAttachment",
        "LeftFootAttachment",
    },
    RightLeg = {
        "LowerTorso",
        "RightUpperLeg",
        "RightLowerLeg",
        "RightFoot",
        "RightHip",
        "RightHipRigAttachment",
        "RightKneeRigAttachment",
        "RightAnkleRigAttachment",
        "RightFootAttachment",
    },
}
Appendage.ConstraintPresets = {
    LeftArm = {
        {
            Type = "BallSocketConstraint",
            Attachment0 = {
                Part = "UpperTorso",
                Attachment = "LeftShoulderRigAttachment",
                Offset = CFrame.Angles(0, math.pi, 0),
            },
            Attachment1 = {
                Part = "LeftUpperArm",
                Attachment = "LeftShoulderRigAttachment",
                Offset = CFrame.Angles(0, math.pi, -math.pi / 2),
            },
            Properties = {
                Name = "LeftShoulderBallSocket",
                LimitsEnabled = true,
                UpperAngle = 110,
                TwistLimitsEnabled = true,
                TwistLowerAngle = -85,
                TwistUpperAngle = 85,
            },
        },
        {
            Type = "BallSocketConstraint",
            Attachment0 = {
                Part = "LeftUpperArm",
                Attachment = "LeftElbowRigAttachment",
                Offset = CFrame.identity,
            },
            Attachment1 = {
                Part = "LeftLowerArm",
                Attachment = "LeftElbowRigAttachment",
                Offset = CFrame.identity,
            },
            Properties = {
                Name = "LeftElbowBallSocket",
                LimitsEnabled = true,
                UpperAngle = 20,
                TwistLimitsEnabled = true,
                TwistLowerAngle = 5,
                TwistUpperAngle = 120,
            },
        },
    },
    RightArm = {
        {
            Type = "BallSocketConstraint",
            Attachment0 = {
                Part = "UpperTorso",
                Attachment = "RightShoulderRigAttachment",
                Offset = CFrame.identity,
            },
            Attachment1 = {
                Part = "RightUpperArm",
                Attachment = "RightShoulderRigAttachment",
                Offset = CFrame.Angles(0, 0, -math.pi / 2),
            },
            Properties = {
                Name = "RightShoulderBallSocket",
                LimitsEnabled = true,
                UpperAngle = 110,
                TwistLimitsEnabled = true,
                TwistLowerAngle = -85,
                TwistUpperAngle = 85,
            },
        },
        {
            Type = "BallSocketConstraint",
            Attachment0 = {
                Part = "RightUpperArm",
                Attachment = "RightElbowRigAttachment",
                Offset = CFrame.identity,
            },
            Attachment1 = {
                Part = "RightLowerArm",
                Attachment = "RightElbowRigAttachment",
                Offset = CFrame.identity,
            },
            Properties = {
                Name = "RightElbowBallSocket",
                LimitsEnabled = true,
                UpperAngle = 20,
                TwistLimitsEnabled = true,
                TwistLowerAngle = 5,
                TwistUpperAngle = 120,
            },
        },
    },
    LeftLeg = {
        {
            Type = "BallSocketConstraint",
            Attachment0 = {
                Part = "LowerTorso",
                Attachment = "LeftHipRigAttachment",
                Offset = CFrame.identity,
            },
            Attachment1 = {
                Part = "LeftUpperLeg",
                Attachment = "LeftHipRigAttachment",
                Offset = CFrame.identity,
            },
            Properties = {
                Name = "LeftHipBallSocket",
                LimitsEnabled = true,
                UpperAngle = 40,
                TwistLimitsEnabled = true,
                TwistLowerAngle = -5,
                TwistUpperAngle = 80,
            },
        },
        {
            Type = "BallSocketConstraint",
            Attachment0 = {
                Part = "LeftUpperLeg",
                Attachment = "LeftKneeRigAttachment",
                Offset = CFrame.identity,
            },
            Attachment1 = {
                Part = "LeftLowerLeg",
                Attachment = "LeftKneeRigAttachment",
                Offset = CFrame.identity,
            },
            Properties = {
                Name = "LeftKneeBallSocket",
                LimitsEnabled = true,
                UpperAngle = 5,
                TwistLimitsEnabled = true,
                TwistLowerAngle = -120,
                TwistUpperAngle = 5,
            },
        },
    },
    RightLeg = {
        {
            Type = "BallSocketConstraint",
            Attachment0 = {
                Part = "LowerTorso",
                Attachment = "RightHipRigAttachment",
                Offset = CFrame.identity,
            },
            Attachment1 = {
                Part = "RightUpperLeg",
                Attachment = "RightHipRigAttachment",
                Offset = CFrame.identity,
            },
            Properties = {
                Name = "RightHipBallSocket",
                LimitsEnabled = true,
                UpperAngle = 40,
                TwistLimitsEnabled = true,
                TwistLowerAngle = -5,
                TwistUpperAngle = 80,
            },
        },
        {
            Type = "BallSocketConstraint",
            Attachment0 = {
                Part = "RightUpperLeg",
                Attachment = "RightKneeRigAttachment",
                Offset = CFrame.identity,
            },
            Attachment1 = {
                Part = "RightLowerLeg",
                Attachment = "RightKneeRigAttachment",
                Offset = CFrame.identity,
            },
            Properties = {
                Name = "RightKneeBallSocket",
                LimitsEnabled = true,
                UpperAngle = 5,
                TwistLimitsEnabled = true,
                TwistLowerAngle = -120,
                TwistUpperAngle = 5,
            },
        },
    },
}
Appendage.__index = Appendage
setmetatable(Appendage, Limb)

export type Appendage = {
    Destroyed: boolean,
    ActiveTweens: {[Instance]: {[string]: Tween}},
    RootPart: BasePart,
    UpperLimb: BasePart,
    LowerLimb: BasePart,
    LimbEnd: BasePart,
    StartMotor: Motor6D | AnimationConstraint,
    StartAttachment: string,
    LimbJointAttachment: string,
    LimbEndAttachment: string,
    LimbHoldAttachment: string,
    AllowDisconnection: boolean,
    IKControlAttachment: Attachment,
    IKControl: IKControl,
    Constraints: {Instance},
} & typeof(setmetatable({},Appendage )) &  Limb.Limb



--[[
Creates an appendage.
--]]
function Appendage.new(Humanoid: Humanoid, RootPart: BasePart, UpperLimb: BasePart, LowerLimb: BasePart, LimbEnd: BasePart, StartMotor: string, StartAttachment: string, LimbJointAttachment: string, LimbEndAttachment: string, LimbHoldAttachment: string, AllowDisconnection: boolean?, SmoothTime: number?): Appendage
    --Store the parts.
    local self = setmetatable(Limb.new() :: any, Appendage) :: Appendage
    self.Destroyed = false
    self.ActiveTweens = {}
    self.RootPart = RootPart
    self.UpperLimb = UpperLimb
    self.LowerLimb = LowerLimb
    self.LimbEnd = LimbEnd
    self.StartMotor = UpperLimb:WaitForChild(StartMotor) :: Motor6D
    self.StartAttachment = StartAttachment
    self.LimbJointAttachment = LimbJointAttachment
    self.LimbEndAttachment = LimbEndAttachment
    self.LimbHoldAttachment = LimbHoldAttachment
    self.AllowDisconnection = AllowDisconnection or false
    self.Constraints = {}

    --Prepare the motor if it is a AnimationConstraint.
    if self.StartMotor:IsA("AnimationConstraint") then
        self.AllowDisconnection = false --TODO: Set up moving attachment instead.
    end

    --Create arbitrary end attachments.
    if (LimbHoldAttachment == "LeftFootAttachment" or LimbHoldAttachment == "RightFootAttachment") and not LimbEnd:FindFirstChild(LimbHoldAttachment) then
        local EndAttachment = Instance.new("Attachment")
        EndAttachment.Name = LimbHoldAttachment
        EndAttachment.CFrame = CFrame.new(0, -LimbEnd.Size.Y / 2, 0)
        EndAttachment.Parent = LimbEnd

        local OriginalPositionValue = Instance.new("Vector3Value")
        OriginalPositionValue.Name = "OriginalPosition"
        OriginalPositionValue.Value = EndAttachment.Position
        OriginalPositionValue.Parent = EndAttachment
    end

    --Prepare the IKControl.
    if not Humanoid:FindFirstChildOfClass("Animator") then
        Instance.new("Animator").Parent = Humanoid
    end

    local IKControlAttachment = Instance.new("Attachment")
    IKControlAttachment.Name = `{UpperLimb.Name}_{LowerLimb.Name}_Attachment`
    IKControlAttachment.Parent = RootPart
    self.IKControlAttachment = IKControlAttachment

    local IKControl = Instance.new("IKControl")
    IKControl.Name = `{UpperLimb.Name}_{LowerLimb.Name}_IKControl`
    IKControl.ChainRoot = UpperLimb
    IKControl.EndEffector = LimbEnd
    IKControl.Offset = self:GetAttachmentCFrame(LimbEnd, LimbHoldAttachment):Inverse()
    IKControl.SmoothTime = SmoothTime or 0
    IKControl.Target = IKControlAttachment
    IKControl.Parent = Humanoid
    self.IKControl = IKControl
    self:MoveTo(self:GetAttachmentCFrame(UpperLimb, StartAttachment):Inverse() * self:GetAttachmentCFrame(UpperLimb, LimbJointAttachment) * self:GetAttachmentCFrame(LowerLimb, LimbJointAttachment):Inverse() * self:GetAttachmentCFrame(LowerLimb, LimbEndAttachment) * self:GetAttachmentCFrame(LimbEnd, LimbEndAttachment):Inverse() * self:GetAttachmentCFrame(LimbEnd, LimbHoldAttachment))

    --Return the object.
    return self
end

--[[
Creates an appendage using a CFrame.
--]]
function Appendage.FromPreset(PresetName: string, Character: Model, AllowDisconnection: boolean?, SmoothTime: number?): Appendage
    local Preset = Appendage.Presets[PresetName]
    local AppendageInstance = Appendage.new(Character:WaitForChild("Humanoid") :: Humanoid, Character:WaitForChild(Preset[1]) :: BasePart, Character:WaitForChild(Preset[2]) :: BasePart, Character:WaitForChild(Preset[3]) :: BasePart, Character:WaitForChild(Preset[4]) :: BasePart, Preset[5], Preset[6], Preset[7], Preset[8], Preset[9], AllowDisconnection, SmoothTime)
    AppendageInstance:AddConstraints(PresetName, Character)
    return AppendageInstance
end

--[[
Sets a property with an optional TweenInfo.
--]]
function Appendage.SetProperty(self: Appendage, Ins: any, PropertyName: string, PropertyValue: any, TweenInfoObject: TweenInfo?): ()
    if self.Destroyed then return end
    if TweenInfoObject then
        if not self.ActiveTweens[Ins] then self.ActiveTweens[Ins] = {} end
        local Tween = TweenService:Create(Ins, TweenInfoObject, {
            [PropertyName] = PropertyValue,
        })
        Tween:Play()
        self.ActiveTweens[Ins][PropertyName] = Tween
    else
        Ins[PropertyName] = PropertyValue
    end
end

--[[
Adds constraints for an appendage.
--]]
function Appendage.AddConstraints(self: Appendage, PresetName: string, Character: Model): ()
    for _, ConstraintPreset in Appendage.ConstraintPresets[PresetName] do
        local Attachment0Part = Character:WaitForChild(ConstraintPreset.Attachment0.Part) :: BasePart
        local Attachment1Part = Character:WaitForChild(ConstraintPreset.Attachment1.Part) :: BasePart

        --Ignore the constraint if the joint is already constrained.
        if Attachment1Part:FindFirstChildOfClass(ConstraintPreset.Type) then continue end

        --Get the attachments.
        local Attachment0 = Attachment0Part:WaitForChild(ConstraintPreset.Attachment0.Attachment) :: Attachment
        if ConstraintPreset.Attachment0.Offset ~= CFrame.identity then
            local NewAttachment0 = Attachment0:Clone()
            NewAttachment0.Name = "NexusAppendageConstraintOffset"
            NewAttachment0.CFrame = ConstraintPreset.Attachment0.Offset
            NewAttachment0.Parent = Attachment0
            table.insert(self.Constraints, NewAttachment0)
            Attachment0 = NewAttachment0
        end
        local Attachment1 = Attachment1Part:WaitForChild(ConstraintPreset.Attachment1.Attachment) :: Attachment
        if ConstraintPreset.Attachment1.Offset ~= CFrame.identity then
            local NewAttachment1 = Attachment1:Clone()
            NewAttachment1.Name = "NexusAppendageConstraintOffset"
            NewAttachment1.CFrame = ConstraintPreset.Attachment1.Offset
            NewAttachment1.Parent = Attachment1
            table.insert(self.Constraints, NewAttachment1)
            Attachment1 = NewAttachment1
        end

        --Create the constraint.
        local Constraint = Instance.new(ConstraintPreset.Type) :: any
        for Name, Value in ConstraintPreset.Properties do
            Constraint[Name] = Value
        end
        Constraint.Attachment0 = Attachment0
        Constraint.Attachment1 = Attachment1
        Constraint.Parent = Attachment1Part
        table.insert(self.Constraints, Constraint)
    end
end

--[[
Enables the appendage.
--]]
function Appendage.Enable(self: Appendage): ()
    self.IKControl.Weight = 1
end

--[[
Disables the appendage.
--]]
function Appendage.Disable(self: Appendage): ()
    self.IKControl.Weight = 0
end

--[[
Sets the target attachment for the IKControl.
MoveTo and MoveToWorld will not work when a target attachment is set.
--]]
function Appendage.SetTargetAttachment(self: Appendage, Target: Attachment?): ()
    self.IKControl.Target = Target or self.IKControlAttachment
end

--[[
Sets the smoothing time.
--]]
function Appendage.SetSmoothTime(self: Appendage, SmoothTime: number): ()
    self.IKControl.SmoothTime = SmoothTime
end

--[[
Moves the appendage target to the given CFrame relative to the
attachment the upper limb rotates at.
--]]
function Appendage.MoveTo(self: Appendage, Target: CFrame, TweenInfoObject: TweenInfo?): ()
    --Move the target CFrame.
    local StartAttachmentCFrame = self:GetAttachmentCFrame(self.RootPart, self.StartAttachment)
    self:SetProperty(self.IKControlAttachment, "CFrame", StartAttachmentCFrame * Target, TweenInfoObject)

    --Move the Motor6D if disconnection is allowed.
    if not self.AllowDisconnection then return end
    local TargetEndJointCFrame = Target * self:GetAttachmentCFrame(self.LimbEnd, self.LimbHoldAttachment):Inverse() * self:GetAttachmentCFrame(self.LimbEnd, self.LimbEndAttachment)
    local AppendageLength = (self:GetAttachmentCFrame(self.UpperLimb, self.StartAttachment):Inverse() * self:GetAttachmentCFrame(self.UpperLimb, self.LimbJointAttachment) * self:GetAttachmentCFrame(self.LowerLimb, self.LimbJointAttachment):Inverse() * self:GetAttachmentCFrame(self.LowerLimb, self.LimbEndAttachment)).Position.Magnitude
    local TargetLength = TargetEndJointCFrame.Position.Magnitude
    if TargetLength > AppendageLength then
        self:SetProperty(self.StartMotor, "C0", StartAttachmentCFrame * CFrame.new(CFrame.new(Vector3.zero, TargetEndJointCFrame.Position).LookVector * (TargetLength - AppendageLength)), TweenInfoObject)
    else
        self:SetProperty(self.StartMotor, "C0", StartAttachmentCFrame, TweenInfoObject)
    end
end

--[[
Moves the appendage target to the given CFrame in world space.
--]]
function Appendage.MoveToWorld(self: Appendage, Target: CFrame, TweenInfoObject: TweenInfo?): ()
    local StartCFrame = self.RootPart.CFrame * self:GetAttachmentCFrame(self.RootPart, self.StartAttachment)
    self:MoveTo(StartCFrame:Inverse() * Target)
end

--[[
Destroys the appendage.
--]]
function Appendage.Destroy(self: Appendage): ()
    self.Destroyed = true

    --Reset the properties.
    for _, Tweens in self.ActiveTweens do
        for _, Tween in Tweens do
            Tween:Cancel()
        end
    end
    if self.StartMotor:IsA("Motor6D") then
        self.StartMotor.C0 = self:GetAttachmentCFrame(self.RootPart, self.StartAttachment)
    elseif self.StartMotor:IsA("AnimationConstraint") then
        --TODO: Reset attachment.
    end

    --Clear the IKControl.
    self.IKControlAttachment:Destroy()
    self.IKControl:Destroy()
    for _, Constraint in self.Constraints do
        Constraint:Destroy()
    end
end



return Appendage