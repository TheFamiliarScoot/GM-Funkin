buffer_seek(data, buffer_seek_start, 0);
var required_size = fmod_dsp_get_parameter_data(dsp, FMOD_DSP_FFT.SPECTRUMDATA, data);
while buffer_get_size(data) < required_size {
	buffer_resize(data, required_size);
	required_size = fmod_dsp_get_parameter_data(dsp, FMOD_DSP_FFT.SPECTRUMDATA, data);
}

var length = buffer_read(data, buffer_s32);
var numchannels = buffer_read(data, buffer_s32);
if spectrum_data == -1 {
	spectrum_data = array_create(numchannels, array_create(length, 0));
}
for (var c = 0; c < numchannels; c++) {
	for (var b = 0; b < length; b++) {
		spectrum_data[c][b] = buffer_read(data, buffer_f32);
	}
}
if samples == -1 {
	samples = array_create(length, 0);	
}
for (var b = 0; b < length; b++) {
	var total_data = 0;
	for (var c = 0; c < numchannels; c++) {
		total_data += spectrum_data[c][b];	
	}
	samples[b] = total_data / numchannels;
}