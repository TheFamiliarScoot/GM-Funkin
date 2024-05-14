function onLoad(song)
	print("song: " .. tostring(song))
	local pico_data = loadConductorData("funkin", song, "picospeaker", false)
	print("data: " .. tostring(pico_data))
	local pico_conductor = createConductor(pico_data, 0, 0, "Instances")
	print("conductor: " .. tostring(pico_conductor))
	for i in 4 do
		local strum = createStrum(pico_conductor, 0, 0, "Instances", i, getCharacter(2))
		strum.visible = false
		strum.isbot = true
		print("strum " .. tostring(i) .. ": " .. tostring(strum))
	end
end

function onNoteHit(note, strum, character)
	print("note time " .. tostring(note.position))
	print(strum)
	print(character)
end

function onEvent(event)
	print("event type " .. event.type)
end