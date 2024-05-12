window_size = 16;

dsp = fmod_system_create_dsp_by_type(FMOD_DSP_TYPE.FFT);
fmod_dsp_set_parameter_int(dsp, FMOD_DSP_FFT.WINDOWTYPE, FMOD_DSP_FFT_WINDOW.RECT);
fmod_dsp_set_parameter_int(dsp, FMOD_DSP_FFT.WINDOWSIZE, window_size);
fmod_channel_control_add_dsp(conductor.channel_inst, 0, dsp);

data = buffer_create(4, buffer_grow, 1);
spectrum_data = [];
samples = [];