slowmode = !slowmode;
if slowmode {
	FMODGMS_Chan_Set_Pitch(chi,0.5);
	FMODGMS_Chan_Set_Pitch(chv,0.5);
}
else {
	FMODGMS_Chan_Set_Pitch(chi,1);
	FMODGMS_Chan_Set_Pitch(chv,1);
}