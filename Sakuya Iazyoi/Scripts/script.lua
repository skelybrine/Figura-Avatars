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

--skirt swing
local swingPhys=require("Scripts.swinging_physics") -- slightly modified
local swingPhysB=require("Scripts.swinging_physicsB") -- used for hair, needed for different physics parameters
function events.entity_init()
    for i=1, 10 do
        s=i*36 --converts skirt part number to degrees

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
        swingPhys.swingOnBody(modelpath.Player.Body.skirt["skirtPart"..i], s, k) --turns on skirt part swing and sets parameters
        print(s)
    end
    --bow tie swing
    swingPhys.swingOnBody(modelpath.Player.Body.bow.tail1, 170, {-45,10,-10,10,-10,10})
    swingPhys.swingOnBody(modelpath.Player.Body.bow.tail2, -170, {-45,10,-10,10,-10,10})
    swingPhys.swingOnBody(modelpath.Player.Body.bow.bow1, 170, {-2,20,-2,20,-5,5})
    swingPhys.swingOnBody(modelpath.Player.Body.bow.bow2, -170, {-2,20,-20,2,-5,5})
    --apron swing
    swingPhys.swingOnBody(modelpath.Player.Body.Apron, 0, {-5,45,-3,3,-3,3})
    --front hair swing
    swingPhysB.swingOnHead(modelpath.Player.Head.Hair.FrontHair.LeftBang, 10, {-20,2,-5,5,-5,5})
    swingPhysB.swingOnHead(modelpath.Player.Head.Hair.FrontHair.RightBang, -10, {-20,2,-5,5,-5,5})
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