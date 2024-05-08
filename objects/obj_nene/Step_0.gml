/// @description Insert description here

event_inherited();

if instance_exists(obj_dsp_spectrum) && is_array(obj_dsp_spectrum.samples) && array_length(obj_dsp_spectrum.samples) > 0 {
	var samples_per_band = obj_dsp_spectrum.window_size / 7;
	var b = 0;
	var s = 0;
	repeat 7 {
		var avg = 0;
		repeat samples_per_band {
			avg += obj_dsp_spectrum.samples[s];
			s++;
		}
		avg /= samples_per_band;
		bands[b] = avg * meter_intensity;
		
		if bands[b] > band_buffer[b] {
			band_buffer[b] = bands[b];
			buffer_decrease[b] = 0.005;
		}
		
		if bands[b] < band_buffer[b] {
			band_buffer[b] -= buffer_decrease[b];
			buffer_decrease[b] *= d(1.2);
		}
		
		if band_buffer[b] < 0 {
			band_buffer[b] = 0;	
		}
		if band_buffer[b] > 1 {
			band_buffer[b] = 1;	
		}
		
		b++;
	}
}