function getSongList()
	return {
		"tutorial",
		"bopeebo",
		"fresh",
		"dadbattle",
		"spookeez",
		"south",
		"monster",
		"pico",
		"philly",
		"blammed",
		"satin-panties",
		"high",
		"milf",
		"cocoa",
		"eggnog",
		"winter-horrorland",
		"senpai",
		"roses",
		"thorns",
		"ugh",
		"guns",
		"stress",
		"darnell"
	}
end

function getSong(song)
	if song == "darnell" then
		local metadata = loadJson(song .. "/" .. song .. "-metadata.json")
		return {
			["fileName"] = song,
			["name"] = metadata.songName,
			["chartType"] = "funkinv3",
			["difficulties"] = metadata.playData.difficulties,
			["instLocation"] = song .. "/Inst.ogg",
			["voicesLocations"] = { song .. "/Voices-darnell.ogg", song .. "/Voices-pico.ogg" }
		}
	else
		return {
			["fileName"] = song,
			["name"] = song,
			["chartType"] = "old",
			["difficulties"] = { "easy", "normal", "hard" },
			["instLocation"] = song .. "/Inst.ogg",
			["voicesLocations"] = { "", song .. "/Voices.ogg" }
		}
	end
end

function getChart(song, difficulty)
	if song == "darnell" then
		return song .. "/" .. song .. "-chart.json"
	else
		local diffaddstring = "-" .. difficulty
		if difficulty == "normal" then
			diffaddstring = ""
		end
		return song .. "/" .. song .. diffaddstring .. ".json"
	end
end