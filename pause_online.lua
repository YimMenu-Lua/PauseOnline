local allow_pausing_code_in_network_game = memory.scan_pattern("75 ? E8 ? ? ? ? C6 05 ? ? ? ? ? EB ? 48 8B 05"):patch_byte({ 0x90, 0x90 })
allow_pausing_code_in_network_game:apply()

local open_pause_menu = memory.scan_pattern("E8 ? ? ? ? E8 ? ? ? ? 33 C9 E8 ? ? ? ? 48 8D 0D"):add(1):rip()

memory.dynamic_hook("open_pause_menu", "void", { "unsigned int", "bool", "unsigned int", "bool" }, open_pause_menu,
function(retval, menu_hash, pause_game, unk1, unk2)
    local hash = menu_hash:get()
    if hash == 0xBA33ADB3 then
        pause_game:set(true)
    end
    return true
end,
function(retval, menu_hash, pause_game, unk1, unk2)
end)