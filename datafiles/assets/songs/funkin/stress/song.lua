function onLoad(song)
	log("song: " .. string(song))
	local pico_data = loadConductorData("funkin", song, "picospeaker", false)
	log("data: " .. string(pico_data))
	local pico_conductor = createConductor(pico_data, 0, 0, "Instances")
	log("conductor: " .. string(pico_conductor))
	for i in 4 do
		local strum = createStrum(pico_conductor, 0, 0, "Instances", i, getCharacter(2))
		strum.visible = false
		strum.isbot = true
		log("strum " .. string(i) .. ": " .. string(strum))
	end
end

function onNoteHit(note, strum, character)

end