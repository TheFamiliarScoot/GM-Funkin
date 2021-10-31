if conductordisplay {
	var text = "BPM: " + string(cond.bpm) + "\n" +
			   "Global Beat: " + string(cond.gbeat) + "\n" +
			   "Global Step: " + string(cond.gstep) + "\n" +
			   "Current Step: " + string(cond.cstep) + "\n" +
			   "Current Beat: " + string(cond.cbeat) + "\n" +
			   "Song Position: " + string(cond.songpos) + "\n" +
			   "Visual Position: " + string(cond.notepos) + "\n" +
			   "Offset: " + string(cond.offset) + "\n" + 
			   "Section: " + string(cond.section);
	draw_text(0,200,text);	
}
lastposition = FMODGMS_Chan_Get_Position(chi);