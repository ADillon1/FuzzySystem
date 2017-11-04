require("scripts.framework")

local default_x = 600
local default_y = 300
local cam_offset = vector:new()

local player = game_object:new({x = 400, y = 300})
local box = game_object:new({x = default_x, y = default_y})

-- angle stuff
local angle = 0
local enemy_angle = 0

-- inputs
local angle_diff = 0
local distance = 0

-- box velocity stuff
local velocity = vector:new()

local distance_ant = tri_member_func:new({a = 50, b = 200, c = 600})
local angle_ant = tri_member_func:new({a = 0, b = 0, c = 45})

function love.load()
    player.image = love.graphics.newImage("player.jpg");
    box.image = love.graphics.newImage("box.jpg")
    print("lua version:", _VERSION)
end

function concequence(x, y) -- z function
    return (x * y) * 10
end

-- use the force lua!
function Apply_Force()
    local dist_out = distance_ant:value(distance)
    local angle_out = angle_ant:R_value(angle_diff)

    local alpha = math.max(dist_out, angle_out) -- calc firing level
    local z = concequence(dist_out, angle_out)

    print(dist_out, angle_out)
    if alpha == 0 then return 0 end
    local force = (alpha * z) / alpha

    local player_pos = vector:new({x = player.x, y = player.y})
    local box_pos = vector:new({x = box.x, y = box.y})
    local vec = box_pos - player_pos

    vec = vec:normalized()
    vec = vec * force
    velocity = vec;
end

function love.keypressed(key)
    if key == "r" then
        player.x = 400
        player.y = 300
        angle = 0
        cam_offset = vector:new()
        box.x = default_x
        box.y = default_y
        velocity = vector:new()
    elseif key == "space" then 
        Apply_Force()
    end
end

function love.update(dt)
    if love.keyboard.isDown("a") then
        angle = (angle - (200 * dt)) % 360
    elseif love.keyboard.isDown("d") then
        angle = (angle + (200 * dt)) % 360
    end

    if love.keyboard.isDown("w") then
        local dir = DirectionVec(math.rad(angle))
        dir = dir * 2
        player.x = player.x + dir.x
        player.y = player.y + dir.y
        cam_offset = cam_offset + dir
    elseif love.keyboard.isDown("s") then
        local dir = DirectionVec(math.rad(angle))
        dir = dir * -2
        player.x = player.x + dir.x
        player.y = player.y + dir.y
        cam_offset = cam_offset + dir
    end

    local player_pos = vector:new({x = player.x, y = player.y})
    local box_pos = vector:new({x = box.x, y = box.y})
    local vec = box_pos - player_pos
    enemy_angle = math.deg(vec:get_angle()) % 360
    angle_diff = math.min((enemy_angle - angle) % 360, (angle - enemy_angle) % 360)
    distance = vec:length()

    -- apply velocity to box.
    box.x = box.x + velocity.x 
    box.y = box.y + velocity.y

    -- friction
    velocity = Friction(velocity, 0.05)
end

function love.draw()
    love.graphics.translate(-cam_offset.x, -cam_offset.y)
    local dir = DirectionVec(math.rad(angle))
    local pos = vector:new({x = player.x, y = player.y})
    local epos = pos + (dir * 100)
    player:draw()
    box:draw()
    love.graphics.line(pos.x, pos.y, epos.x, epos.y)
end
