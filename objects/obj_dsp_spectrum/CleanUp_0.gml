if conductor.channel_inst > -1 { fmod_channel_control_remove_dsp(conductor.channel_inst, dsp); }
fmod_dsp_release(dsp);
buffer_delete(data);