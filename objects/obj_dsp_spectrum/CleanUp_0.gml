if chi > -1 { fmod_channel_control_remove_dsp(chi, dsp); }
fmod_dsp_release(dsp);
buffer_delete(data);