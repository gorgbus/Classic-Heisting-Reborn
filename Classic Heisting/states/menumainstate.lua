local path = SavePath .. "ch_changelog_version.txt"
local new_version = "1.6"

local old_version = ""

function write(x, path)
	local file = io.open(path, "w+")
	if file then
		file:write(x)
		file:close()
	end
end

function read(path)
	local file = io.open(path, "r")
	if file then
        old_version = file:read("*all") or ""
	    file:close()
    else
        old_version = new_version
	end
end

read(path)

local short = MenuMainState.at_enter
function MenuMainState:at_enter(old_state)
	short(self, old_state)

    if new_version ~= old_version then
        write(new_version, path)
        local my_advanced_message = {
            focus_button = 1,
            texture = false,
            title = "menu_ch_changelog_title",
            text = "menu_ch_changelog_text"
        }

        local node1 = {
            text = managers.localization:text("menu_ch_changelog_btn_text")
        }
        
        my_advanced_message.button_list = {
            node1
        }

        managers.menu:show_video_message_dialog(my_advanced_message)
    else
        write(old_version, path)
    end
end