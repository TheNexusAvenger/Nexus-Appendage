--[[
TheNexusAvenger

Tests the Limb class.
--]]
--!strict

local Limb = require(game:GetService("ReplicatedStorage"):WaitForChild("NexusAppendage"):WaitForChild("Limb"))

return function()
    local TestLimb = nil
    beforeEach(function()
        TestLimb = Limb.new()
    end)

    describe("A limb", function()
        it("should return attachment CFrames.", function()
            local TestPart = Instance.new("Part")
            local TestAttachment = Instance.new("Attachment")
            TestAttachment.Name = "TestAttachment"
            TestAttachment.CFrame = CFrame.new(1, 2, 3)
            TestAttachment.Parent = TestPart

            expect(TestLimb:GetAttachmentCFrame(TestPart, "TestAttachment")).to.equal(CFrame.new(1, 2, 3))
        end)

        it("should return for unknown CFrames.", function()
            expect(TestLimb:GetAttachmentCFrame(Instance.new("Part"), "TestAttachment")).to.equal(CFrame.new(0, 0, 0))
        end)
    end)
end