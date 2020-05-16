function S = STFT(signal,fs,window,overlap_len,dft_len,helper_plot)
		n_pts = numel(signal);
		time = linspace(0,(n_pts - 1)/fs,n_pts);
		
		n_frame_samples = round(dft_len*fs);
		n_frame_overlaps = round(overlap_len*fs);
		freq_frame = linfreq_resolution(fs,n_frame_samples);
		
		i = 1;
		nwindows =  1 : n_frame_samples - n_frame_overlaps : n_pts - n_frame_samples;
		S = zeros(1,length(nwindows));
		time_frames = zeros(1,length(nwindows));
		for k = nwindows
			frame = signal(k : k + n_frame_samples - 1).*window;
			frame_dft = abs(fftshift( fft(frame) ));
			index =  find(frame_dft == max(frame_dft),1,"last");
			S(i) = freq_frame(index);
			f_time = time(k : k + n_frame_samples - 1);
			time_frames(i) = f_time(round(n_frame_samples/2) + 1);
			i = i + 1;
		end
		
		if helper_plot == true 
			figure();
			plot(time_frames,S, "ro");
			xlabel("time [s]");
			ylabel("Frequency [Hz]");
			title("STFT ( frequency/window)");
			grid on;
		end
		
end



function F = linfreq_resolution(fs,n_samples)
	if mod(n_samples,2) == 0
	    F = -fs/2 : fs/n_samples : fs/2 - fs/n_samples;
	else
	    F = -fs/2 + fs/(2*n_samples) : fs/n_samples : fs/2 - fs/(2*n_samples);
	end
end