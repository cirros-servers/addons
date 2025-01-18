hook.Add("ChatText", "hide_joinleave", function( index, name, text, type )
	if type == "joinleave" then
		return true
	end
end)