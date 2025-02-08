--Base class for a limb.
--!strict

local Limb = {}
Limb.__index = Limb

export type Limb = typeof(setmetatable({}, Limb))



--[[
Creates a limb object.
--]]
function Limb.new(): Limb
    return setmetatable({}, Limb) :: Limb
end

--[[
Returns the CFrame of an attachment.
Returns an empty CFrame if the attachment
does not exist.
--]]
function Limb.GetAttachmentCFrame(self: Limb, Part: BasePart, AttachmentName: string): CFrame
    local Attachment = Part:FindFirstChild(AttachmentName) :: Attachment
    return Attachment and Attachment.CFrame or CFrame.identity
end



return Limb