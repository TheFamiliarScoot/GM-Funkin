if conductordisplay {
	var text = "BPM: " + string(bpm) + "\n" +
			   "Global Beat: " + string(gbeat) + "\n" +
			   "Global Step: " + string(gstep) + "\n" +
			   "Current Step: " + string(cstep) + "\n" +
			   "Current Beat: " + string(cbeat) + "\n" +
			   "Song Position: " + string(songpos) + "\n" +
			   "Visual Position: " + string(notepos) + "\n" +
			   "Offset: " + string(offset);
	draw_text(0,200,text);	
}