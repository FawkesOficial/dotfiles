-- Full border [disabled]
-- https://yazi-rs.github.io/docs/tips/#full-border
-- require("full-border"):setup()

-- Show symlink in status bar
-- https://yazi-rs.github.io/docs/tips/#symlink-in-status
function Status:name()
    local h = self._tab.current.hovered
    if not h then
        return ui.Line {}
    end

    local linked = ""
    if h.link_to ~= nil then
        linked = " -> " .. tostring(h.link_to)
    end
    return ui.Line(" " .. h.name .. linked)
end

-- Show user/group of files in status bar
-- https://yazi-rs.github.io/docs/tips/#user-group-in-status
Status:children_add(function()
    local h = cx.active.current.hovered
    if h == nil or ya.target_family() ~= "unix" then
        return ui.Line {}
    end

    return ui.Line {
        ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
        ui.Span(":"),
        ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
        ui.Span(" "),
    }
end, 500, Status.RIGHT)

-- Show username and hostname in header
-- https://yazi-rs.github.io/docs/tips/#username-hostname-in-header
Header:children_add(function()
    if ya.target_family() ~= "unix" then
        return ui.Line {}
    end
    return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)

-- git
-- https://github.com/yazi-rs/plugins/tree/main/git.yazi
require("git"):setup()
