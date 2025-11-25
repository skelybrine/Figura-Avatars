--Sakuya Izayoi by Skelybrine

--misc setup stuff
modelpath=models.sakuya

--hide vanilla model
vanilla_model.PLAYER:setVisible(false)

--hide vanilla armor model
vanilla_model.ARMOR:setVisible(false)
--re-enable the helmet item
vanilla_model.HELMET_ITEM:setVisible(true)

--hide vanilla cape model
vanilla_model.CAPE:setVisible(false)

--hide vanilla elytra model
vanilla_model.ELYTRA:setVisible(false)
modelpath.World.bone:setVisible(false)
modelpath.World.bone2:setVisible(false)


modelpath.World.bone:setPrimaryRenderType("cutout_EMISSIVE_solid")
--modelpath.World.bone:setSecondaryRenderType("")
modelpath.World.bone:setOpacity(1)

modelpath.World.bone2:setPrimaryRenderType("end_portal")
--modelpath.World.bone:setSecondaryRenderType("")
modelpath.World.bone2:setOpacity(1)

--skirt swing
local swingPhys=require("Scripts.swinging_physics") -- slightly modified
local swingPhysB=require("Scripts.swinging_physicsB") -- used for hair, needed for different physics parameters


function pings.skirtPhys(state) --toggle for skirt physics, set to true in entity_init
        for i=1, 10 do
            s=i*36 --converts skirt part number to degrees
            if state==true then
                if s>=180 then --changes 360 degree system to 180/-180 (blockbench)
                    s=-180+s-180
                    end
                    if i>=4 and i<=7 then --finds rear skirt parts and sets limits
                        k={-45,10,-10,10,-10,10}
                    elseif i==8 or i==3 then --finds side skirt parts and sets limits
                        k={-20,20,-10,10,-5,5}
                    else -- all other skirt parts (front) and sets limits
                        k={-10,45,-10,10,-10,10}
                    end
            elseif state==false then
                local s=0
                local k={1,1,1,1,1,1}
            end
            swingPhys.swingOnBody(modelpath.Player.Body.skirt["skirtPart"..i], s, k) --turns on skirt part swing and sets parameters
        end
end

function events.entity_init()
    pings.skirtPhys(true)
    --bow tie swing
    swingPhys.swingOnBody(modelpath.Player.Body.bow.tail1, 170, {-45,10,-10,10,-10,10})
    swingPhys.swingOnBody(modelpath.Player.Body.bow.tail2, -170, {-45,10,-10,10,-10,10})
    swingPhys.swingOnBody(modelpath.Player.Body.bow.bow1, 170, {-2,20,-2,20,-5,5})
    swingPhys.swingOnBody(modelpath.Player.Body.bow.bow2, -170, {-2,20,-20,2,-5,5})
    --apron swing
    swingPhys.swingOnBody(modelpath.Player.Body.Apron, 0, {-5,45,-3,3,-3,3})
    --front hair swing
    swingPhysB.swingOnHead(modelpath.Player.Head.Hair.FrontHair.LeftBang, 10, {-2,10,-5,5,-5,5})
    swingPhysB.swingOnHead(modelpath.Player.Head.Hair.FrontHair.RightBang, -10, {-2,10,-5,5,-5,5})
    --braid swing
    swingPhysB.swingOnHead(modelpath.Player.Head.Hair.Braids.LeftBraid, 45, {-30, 90, -90, 90, -90, 90})
    swingPhysB.swingOnHead(modelpath.Player.Head.Hair.Braids.RightBraid, -45, {-30, 90, -90, 90, -90, 90})
end

--physbones
physBone=require("Scripts.physBoneAPI")
function events.entity_init()
    --booba
    physBone.physBoob:setSpringForce(320)
end

--squapi
local squapi=require("Scripts.SquAPI")
--reserved for future use

--eye anims
local gaze=require("Scripts.Gaze")
local eyeAnims=gaze:newGaze()
eyeAnims:newAnim(
    animations.sakuya.eyeHorizontal,
    animations.sakuya.eyeVertical
)
eyeAnims.config.socialInterest=0.05
eyeAnims.config.soundInterest=0.05
eyeAnims.config.faceDirection = true
eyeAnims:newBlink(animations.sakuya.blink)

function events.entity_init()
    modelpath.Player:copy("EHud"):moveTo(modelpath.HUD):setPos(-90, -25, 90):setRot(180, 150, 0)  --base code for the mini-me
    modelpath.HUD.EHud:setVisible(false)
end





--ACTION WHEEL

mainPage=action_wheel:newPage()
animPage=action_wheel:newPage()
custPage=action_wheel:newPage()
physPage=action_wheel:newPage()
action_wheel:setPage(mainPage)

local animPageSel=mainPage:newAction()
    :title("Animations")
    :item("armor_stand")
    :onLeftClick(function()action_wheel:setPage(animPage)end)

local mainPageSel=animPage:newAction()
    :title("Back")
    :item("book")
    :onLeftClick(function()action_wheel:setPage(mainPage)end)

local custPageSel=mainPage:newAction()
    :title("Customizations")
    :item("cherry_sapling")
    :onLeftClick(function()action_wheel:setPage(custPage)end)

local mainPageSel=custPage:newAction()
    :title("Back")
    :item("book")
    :onLeftClick(function()action_wheel:setPage(mainPage)end)

local physPageSel=custPage:newAction()
    :title("Physics Toggles")
    :item("painting")
    :onLeftClick(function()action_wheel:setPage(physPage)end)

local custPageSel=physPage:newAction()
    :title("back")
    :item("book")
    :onLeftClick(function()action_wheel:setPage(custPage)end)

function pings.knifeDome(state)
    if state==true then
        animations.sakuya.spherespin:stop()
        modelpath.World.bone:setVisible(false)
        modelpath.World.bone2:setVisible(false)
        local eyePos = player:getPos() + vec(0, player:getEyeHeight(), 0)
        local eyeEnd = eyePos + (player:getLookDir() * 20)
        block, hitPos, side = raycast:block(eyePos, eyeEnd)
        animations.sakuya.spherespin:play()
    else
        modelpath.World.bone:setVisible(false)
        modelpath.World.bone2:setVisible(false)
        animations.sakuya.spherespin:stop()
        modelpath.Player:setParentType("Player")
        modelpath.Player:setPos(0,0,0)
        modelpath.Player:setRot(0,0,0)
        for i=1, 10 do
            modelpath.World["ee"..i]:setVisible(false)
        end
    end
end

local knifeDome = animPage:newAction()
    :title("Knife Dome")
    :item("diamond_sword")
    :setOnToggle(pings.knifeDome)

function miniMe(state)
    if state==true then
        modelpath.HUD.EHud:setVisible(true)
    elseif state==false then
        modelpath.HUD.EHud:setVisible(false)
    end
end

local miniMeTog=custPage:newAction()
    :title("Mini-Me Toggle"..string.char(10).."may be broken in older versions, made for 1.21.6+")
    :item("player_head")
    :setOnToggle(miniMe)

local skitPhysTog=physPage:newAction()
    :title("Toggle Skirt Physics")
    :item("blue_banner")
    :setOnToggle(pings.skirtPhys)





function swordse(i, state)
    modelpath.World.ee:copy("ee" .. i):moveTo(modelpath.World)
    ea = "ee" .. i
    modelpath.World[ea]:setScale(10, 10, 10)
    modelpath.World[ea]:setPos(hitPos*16+vectors.rotateAroundAxis(36*i, vec(0, -0.5, 3), vec(0,1,0))*16)
    modelpath.World[ea]:setVisible(true)
end

function swordsa(state)
    local wrldtime = world.getTime()
    local i=1
    function events.tick()
        if wrldtime-wrldtime+i <= 10 then
            swordse(i, state)
        end
        i=i+1
    end
end

