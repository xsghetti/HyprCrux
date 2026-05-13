local HOME    = os.getenv("HOME") or ""
local OVERLAY = HOME .. "/.cache/noctalia/HVE/overlay.conf"

local function readlines(path)
    local f = io.open(path, "r")
    if not f then return nil end
    local lines = {}
    for raw in f:lines() do
        local line = raw:gsub("#.*", "")
        line = line:match("^%s*(.-)%s*$") or ""
        if line ~= "" then lines[#lines + 1] = line end
    end
    f:close()
    return lines
end

local function split_csv(s)
    local out = {}
    for part in (s .. ","):gmatch("(.-),") do
        out[#out + 1] = part:match("^%s*(.-)%s*$")
    end
    return out
end

local function truthy(v)
    return v == "yes" or v == "true" or v == "1" or v == "on"
end

local vars        = {}
local generalCfg  = {}
local groupCfg    = { groupbar = {} }

local function expand(s)
    return (s:gsub("%$([%w_]+)", function(n) return vars[n] or ("$" .. n) end))
end

local process_file

local function apply(blockPath, key, value)
    value = expand(value)

    if blockPath == "" then
        if key == "source" then
            process_file(value)
        elseif key == "bezier" then
            local p = split_csv(value)
            hl.curve(p[1], { type = "bezier",
                points = { { tonumber(p[2]), tonumber(p[3]) },
                           { tonumber(p[4]), tonumber(p[5]) } } })
        end

    elseif blockPath == "animations" then
        if key == "enabled" then
            hl.config({ animations = { enabled = truthy(value) } })
        elseif key == "bezier" then
            local p = split_csv(value)
            hl.curve(p[1], { type = "bezier",
                points = { { tonumber(p[2]), tonumber(p[3]) },
                           { tonumber(p[4]), tonumber(p[5]) } } })
        elseif key == "animation" then
            local p = split_csv(value)
            local anim = {
                leaf    = p[1],
                enabled = p[2] == "1",
                speed   = tonumber(p[3]),
                bezier  = p[4],
            }
            if p[5] and p[5] ~= "" then anim.style = p[5] end
            hl.animation(anim)
        end

    elseif blockPath == "general" then
        if key == "border_size" then
            generalCfg.border_size = tonumber(value)
        elseif key:match("^col%.") then
            generalCfg.col = generalCfg.col or {}
            generalCfg.col[key:sub(5)] = value
        end

    elseif blockPath == "group" then
        if key:match("^col%.") then
            groupCfg.col = groupCfg.col or {}
            groupCfg.col[key:sub(5)] = value
        end

    elseif blockPath == "group/groupbar" then
        if key:match("^col%.") then
            groupCfg.groupbar.col = groupCfg.groupbar.col or {}
            groupCfg.groupbar.col[key:sub(5)] = value
        end
    end
end

process_file = function(path)
    local lines = readlines(path)
    if not lines then return end

    local stack = {}
    for _, line in ipairs(lines) do
        if line == "}" then
            table.remove(stack)
        else
            local bname = line:match("^([%w_]+)%s*{$")
            if bname then
                table.insert(stack, bname)
            else
                local k, v = line:match("^([^=]+)=(.*)$")
                if k then
                    k = k:match("^%s*(.-)%s*$")
                    v = v:match("^%s*(.-)%s*$")
                    if k:sub(1, 1) == "$" then
                        vars[k:sub(2)] = expand(v)
                    else
                        apply(table.concat(stack, "/"), k, v)
                    end
                end
            end
        end
    end
end

process_file(OVERLAY)

local cfg = {}
if next(generalCfg) then cfg.general = generalCfg end
if (groupCfg.col and next(groupCfg.col)) or (groupCfg.groupbar.col and next(groupCfg.groupbar.col)) then
    cfg.group = groupCfg
end
if next(cfg) then hl.config(cfg) end
