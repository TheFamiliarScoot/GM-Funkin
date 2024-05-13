function getSongList()
	return {
		"improbable-outset",
		"madness",
		"hellclown",
		"expurgation"
	}
end

function getSong(song)
	local diffs = { "easy", "normal", "hard" }
	if song == "expurgation" then
		diffs = { "hard" }
	end
	return {
		["fileName"] = song,
		["name"] = song,
		["chartType"] = "old",
		["difficulties"] = diffs,
		["instLocation"] = "songs/" .. song .. "/Inst.ogg",
		["voicesLocations"] = { "", "songs/" .. song .. "/Voices.ogg" }
	}
end

function getChart(song, difficulty)
	local diffaddstring = "-" .. difficulty
	if difficulty == "normal" then
		diffaddstring = ""
	end
	return "songs/" .. song .. "/" .. song .. diffaddstring .. ".json"
end

function getSpecialNoteType(note_obj)
	if note_obj[2] > 7 then
		return 1
	end
end