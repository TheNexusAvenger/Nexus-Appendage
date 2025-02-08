--Controls the offset of a joint.
--!strict

local TweenService = game:GetService("TweenService")

local JointOffset = {}
JointOffset.__index = JointOffset

export type JointType = "Motor6D" | "AnimationConstraint"
export type JointOffset = {
    JointType: JointType,
    Destroyed: boolean,
    Motor: Motor6D | AnimationConstraint,
    Part0: BasePart,
    StartAttachment: Attachment?,
    AttachmentCFrame: CFrame,
    ActiveTweens: {[Instance]: {[string]: Tween}},
    EventConnections: {RBXScriptConnection},
} & typeof(setmetatable({}, JointOffset))



--[[
Creates a JointOffset.
--]]
function JointOffset.new(Motor: Motor6D | AnimationConstraint, Part0: BasePart, AttachmentName: string): JointOffset
    --Create the initial object.
    local self = setmetatable({
        JointType = Motor.ClassName :: JointType,
        Destroyed = false,
        Motor = Motor,
        Part0 = Part0,
        AttachmentCFrame = CFrame.identity,
        ActiveTweens = {},
        EventConnections = {},
    }, JointOffset) :: JointOffset

    --Connect the attachment.
    table.insert(self.EventConnections, Part0.ChildAdded:Connect(function(Attachment)
        if Attachment.Name ~= AttachmentName or not Attachment:IsA("Attachment") then return end
        self:ConnectAttachment(Attachment)
    end))
    self:ConnectAttachment(Part0:FindFirstChild(AttachmentName) :: Attachment)

    --Return the object.
    return self
end

--[[
Connects an attachment.
--]]
function JointOffset.ConnectAttachment(self: JointOffset, Attachment: Attachment?): ()
    if not Attachment then return end

    --Store the new initial CFrame.
    self.AttachmentCFrame = Attachment.CFrame
    self.StartAttachment = Attachment

    --Try to connect external changes to the event.
    --There is no good way to support external Attachment.CFrame changes with this setup.
    --Checking for the part size changes is "good enough".
    table.insert(self.EventConnections, self.Part0:GetPropertyChangedSignal("Size"):Connect(function()
        if self.StartAttachment ~= Attachment then return end
        self.AttachmentCFrame = Attachment.CFrame
    end))
end

--[[
Sets a property with an optional TweenInfo.
--]]
function JointOffset.SetProperty(self: JointOffset, Ins: any, PropertyName: string, PropertyValue: any, TweenInfoObject: TweenInfo?): ()
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
Sets the offset of the joint.
--]]
function JointOffset.SetOffset(self: JointOffset, Offset: CFrame, TweenInfoObject: TweenInfo?): ()
    if self.JointType == "Motor6D" then
        self:SetProperty(self.Motor, "C0", self.AttachmentCFrame * Offset, TweenInfoObject)
    elseif self.JointType == "AnimationConstraint" and self.StartAttachment then
        self:SetProperty(self.StartAttachment, "CFrame", self.AttachmentCFrame * Offset, TweenInfoObject)
    end
end

--[[
Destorys the joint offset.
--]]
function JointOffset.Destroy(self: JointOffset): ()
    self.Destroyed = true

    --Clear the event connections.
    for _, EventConnection in self.EventConnections do
        EventConnection:Disconnect()
    end

    --Cancel the tweens.
    for _, Tweens in self.ActiveTweens do
        for _, Tween in Tweens do
            Tween:Cancel()
        end
    end
    self.ActiveTweens = {}

    --Reset the offiset.
    if self.Motor:IsA("Motor6D") then
        self.Motor.C0 = self.AttachmentCFrame
    elseif self.Motor:IsA("AnimationConstraint") and self.StartAttachment then
        self.StartAttachment.CFrame = self.AttachmentCFrame
    end
end



return JointOffset